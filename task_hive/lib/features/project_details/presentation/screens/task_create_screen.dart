import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

import '../../domain/entity/assignee_entity.dart';

class CreateTaskScreen extends StatefulWidget {
  final Map<String, dynamic> keyData;
  const CreateTaskScreen({super.key, required this.keyData});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subtaskController = TextEditingController();
  late final int projectId;
  late final int userId;

  String _selectedProject = 'Task Hive';
  String _status = 'To Do';
  String _summary = '';
  String _description = '';
  String? _selectedLabel;
  String? _selectedPriority;
  Assignee? _selectedMember;
  bool _assignToMe = false;
  final List<File> _attachments = [];
  final List<SubTask> _subtasks = [];
  final List<Assignee> _projectMembers =
      ['John Doe', 'Jane Smith', 'Alex Johnson', 'Taylor Swift']
          .map((name) => Assignee(
                name: name,
              ))
          .toList();
  final List<Assignee> _assignedMembers = [];

  DateTime? _startDate;
  DateTime? _dueDate;

  @override
  void initState() {
    projectId = widget.keyData['project_id'] ?? 0;
    userId = widget.keyData['user_id'] ?? 0;
    super.initState();
  }

  final List<String> _statusOptions = [
    'To Do',
    'In Progress',
    'Done',
    'Blocked'
  ];
  final List<String> _labelOptions = [
    'Bug',
    'Feature',
    'Documentation',
    'Enhancement'
  ];

  final List<String> _priorityOptions = [
    'High',
    'Medium',
    'Low',
  ];
  final List<String> _memberOptions = [
    'John Doe',
    'Jane Smith',
    'Alex Johnson',
    'Taylor Swift'
  ];

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setState(() {
          _attachments.addAll(result.paths.map((path) => File(path!)).toList());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking files: $e')),
      );
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  // Subtask methods
  void _addSubtask() {
    if (_subtaskController.text.trim().isNotEmpty) {
      setState(() {
        _subtasks.add(SubTask(title: _subtaskController.text.trim()));
        _subtaskController.clear();
      });
    }
  }

  void _toggleSubtask(int index) {
    setState(() {
      _subtasks[index].isCompleted = !_subtasks[index].isCompleted;
    });
  }

  void _removeSubtask(int index) {
    setState(() {
      _subtasks.removeAt(index);
    });
  }

  void _removeAssignee(int index) {
    setState(() {
      _assignedMembers.removeAt(index);
    });
  }

  // Date picker methods
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        // If due date is before start date, update due date too
        if (_dueDate != null && _dueDate!.isBefore(_startDate!)) {
          _dueDate = _startDate;
        }
      });
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _subtaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create Tasks',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const _FieldLabel(label: 'Status'),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _buildDropdownField(
                    value: _status,
                    items: _statusOptions,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _status = value;
                        });
                      }
                    },
                    validator: (value) => null,
                    // Status always has a default value
                    backgroundColor: const Color(0xFFF5F5F5),
                  ),
                ),
                const SizedBox(height: 16),

                const _FieldLabel(label: 'Title*'),
                const SizedBox(height: 8),
                CustomTextFormField(
                  borderColor: colorScheme.primary,
                  maxLines: 1,
                  hintText: '',
                  onChanged: (value) {
                    _summary = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                const _FieldLabel(label: 'Description'),
                const SizedBox(height: 8),
                CustomTextFormField(
                  borderColor: colorScheme.primary,
                  maxLines: 5,
                  onChanged: (value) {
                    _description = value;
                  },
                  validator: (value) => null,
                  hintText: '',
                ),
                const SizedBox(height: 16),

                // Subtasks Field
                const _FieldLabel(label: 'Subtasks'),
                const SizedBox(height: 8),
                Column(
                  children: [
                    // Subtask list
                    if (_subtasks.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < _subtasks.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () => _toggleSubtask(i),
                                      child: Icon(
                                        _subtasks[i].isCompleted
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: colorScheme.primary,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _subtasks[i].title,
                                        style: TextStyle(
                                          decoration: _subtasks[i].isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: _subtasks[i].isCompleted
                                              ? Colors.grey
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 16),
                                      color: colorScheme.primary,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => _removeSubtask(i),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: _subtaskController,
                          decoration: InputDecoration(
                            hintText: 'Add subtask',
                            hintStyle: textTheme.labelLarge?.copyWith(
                              color: colorScheme.tertiary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                                color: colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: colorScheme.primary,
                              ),
                              onPressed: _addSubtask,
                            ),
                          ),
                          onFieldSubmitted: (_) => _addSubtask(),
                        )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Date Fields (Start Date and Due Date)
                Row(
                  children: [
                    // Start Date Field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FieldLabel(label: 'Start Date'),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _selectStartDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: colorScheme.primary),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _startDate == null
                                          ? 'Select date'
                                          : DateFormat('MMM dd, yyyy')
                                              .format(_startDate!),
                                      style: textTheme.labelLarge?.copyWith(
                                        color: _startDate == null
                                            ? colorScheme.tertiary
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.calendar_today,
                                      size: 18, color: colorScheme.primary),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Due Date Field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FieldLabel(label: 'Due Date'),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _selectDueDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _dueDate == null
                                          ? 'Select date'
                                          : DateFormat('MMM dd, yyyy')
                                              .format(_dueDate!),
                                      style: textTheme.labelLarge?.copyWith(
                                        color: _startDate == null
                                            ? colorScheme.tertiary
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.calendar_today,
                                      size: 18, color: colorScheme.primary),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Labels Field
                const _FieldLabel(label: 'Labels'),
                const SizedBox(height: 8),
                _buildDropdownField(
                  value: _selectedLabel,
                  items: _labelOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedLabel = value;
                    });
                  },
                  validator: (value) => null,
                  // Labels are optional
                  hint: 'Select Label',
                ),
                const SizedBox(height: 16),

                // Priority Field
                const _FieldLabel(label: 'Priority'),
                const SizedBox(height: 8),
                _buildDropdownField(
                  value: _selectedPriority,
                  items: _priorityOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  },
                  validator: (value) => null,
                  // Labels are optional
                  hint: 'Select Priority',
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _FieldLabel(label: 'Assign Members'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _assignToMe = true;
                          _selectedMember = Assignee(name: 'Me');
                        });
                      },
                      child: const Text('Assign To Me',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_assignedMembers.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < _assignedMembers.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Row(
                              children: [
                                // InkWell(
                                //   // onTap: () => _toggleSubtask(i),
                                //   child: Icon(
                                //     _subtasks[i].isCompleted
                                //         ? Icons.check_box
                                //         : Icons.check_box_outline_blank,
                                //     color: colorScheme.primary,
                                //     size: 22,
                                //   ),
                                // ),
                                // const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _assignedMembers[i].name ?? 'N/A',
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, size: 16),
                                  color: colorScheme.primary,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () => _removeAssignee(i),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                _buildMemberDropdown(),
                const SizedBox(height: 16),

                // Attachments Field
                const _FieldLabel(label: 'Attachments'),
                const SizedBox(height: 8),
                Column(
                  children: [
                    // Display selected files
                    if (_attachments.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < _attachments.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      _getFileIcon(_attachments[i].path),
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        path.basename(_attachments[i].path),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 16),
                                      color: Colors.grey,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => _removeAttachment(i),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // Add file button
                    InkWell(
                      onTap: _pickFiles,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.primary),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_file, color: colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              'Add Attachment',
                              style: textTheme.titleMedium?.copyWith(
                                color: colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ///todo: Process data and submit form
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Task created successfully')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Create Task',
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getFileIcon(String filePath) {
    final extension = path.extension(filePath).toLowerCase();

    if (extension.isEmpty) return Icons.insert_drive_file;

    switch (extension) {
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.gif':
      case '.bmp':
        return Icons.image;
      case '.pdf':
        return Icons.picture_as_pdf;
      case '.doc':
      case '.docx':
        return Icons.description;
      case '.xls':
      case '.xlsx':
        return Icons.table_chart;
      case '.ppt':
      case '.pptx':
        return Icons.slideshow;
      case '.mp3':
      case '.wav':
      case '.aac':
        return Icons.audio_file;
      case '.mp4':
      case '.mov':
      case '.avi':
        return Icons.video_file;
      case '.zip':
      case '.rar':
      case '.7z':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required FormFieldValidator<String>? validator,
    String? hint,
    Color? backgroundColor,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            borderSide: BorderSide(width: 1.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hint,
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
    );
  }

  Widget _buildMemberDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Assignee>(
          value: _selectedMember,
          hint: const Text('Select Member'),
          isExpanded: true,
          items: _projectMembers.map((member) {
            return DropdownMenuItem<Assignee>(
              value: member,
              child: Text(member.name ?? 'N/A'),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                if (!_assignedMembers.contains(value)) {
                  _assignedMembers.add(value);
                }
                _selectedMember = null;
              });
            }
          },
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final Color borderColor;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.hintText,
    required this.borderColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

// Model class for subtasks
class SubTask {
  String title;
  bool isCompleted;

  SubTask({required this.title, this.isCompleted = false});
}
