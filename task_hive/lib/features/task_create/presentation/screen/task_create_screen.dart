import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedProject = 'Task Hive';
  String _status = 'To Do';
  String _summary = '';
  String _description = '';
  String? _selectedLabel;
  String? _selectedMember;
  bool _assignToMe = false;
  final List<File> _attachments = [];

  final List<String> _statusOptions = [
    'To Do',
    'In Progress',
    'Done',
    'Blocked'
  ];
  final List<String> _labelOptions = [
    'High Priority',
    'Bug',
    'Feature',
    'Documentation',
    'Enhancement'
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
                // Project Field
                const _FieldLabel(label: 'Project*'),
                const SizedBox(height: 8),
                _buildDropdownField(
                  value: _selectedProject,
                  items: ['Task Hive', 'Project Alpha', 'Team Beta'],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedProject = value;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a project';
                    }
                    return null;
                  },
                ),
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

                const _FieldLabel(label: 'Summary*'),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _summary = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task summary';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                const _FieldLabel(label: 'Description'),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    _description = value;
                  },
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _FieldLabel(label: 'Assign Members'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _assignToMe = true;
                          _selectedMember = 'Me';
                        });
                      },
                      child: const Text('Assign To Me',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildDropdownField(
                  value: _assignToMe ? 'Me' : _selectedMember,
                  items: _memberOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedMember = value;
                      _assignToMe = value == 'Me';
                    });
                  },
                  validator: (value) => null,
                  // Member assignment is optional
                  hint:
                      'Select Label', // This seems to be a UI mistake in the original design
                ),
                const SizedBox(height: 24),

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
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.attach_file, color: Colors.blue),
                            const SizedBox(width: 8),
                            Text(
                              'Add Attachment',
                              style: textTheme.titleMedium?.copyWith(
                                color: Colors.blue,
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
                        // Process data and submit form
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Task created successfully')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Create Task',style: textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),),
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
          child: Text(item,style: Theme.of(context).textTheme.titleMedium,),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        hintText: hint,
        filled: backgroundColor != null,
        fillColor: backgroundColor,
      ),
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
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
