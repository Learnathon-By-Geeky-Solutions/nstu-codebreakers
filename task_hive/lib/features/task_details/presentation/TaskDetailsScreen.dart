import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  double progressValue = 0.6;
  DateTime startDate = DateTime(2022, 2, 21);
  DateTime endDate = DateTime(2022, 3, 3);
  String taskTitle = "UI Design";
  String priority = "Priority Task";
  String description =
      "user interface (UI) is anything a user may interact with to use a digital product or service. This includes everything from screens and touchscreens, keyboards, sounds, and even lights. To understand the evolution of UI, however, it's helpful to learn a bit more about its history and how it has evolved into best practices and a profession.";
  String assignee = "Tahsin";

  List<SubTask> subtasks = [
    SubTask(title: "UI Design", isCompleted: true),
    SubTask(title: "UI Design", isCompleted: true),
    SubTask(title: "UI Design", isCompleted: true),
    SubTask(title: "UI Design", isCompleted: false),
  ];

  List<Attachment> attachments = [
    Attachment(name: "File 1.pdf"),
    Attachment(name: "File 2.pdf"),
    Attachment(name: "File 3.pdf"),
  ];

  TextEditingController newSubtaskController = TextEditingController();

  @override
  void dispose() {
    newSubtaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(colorScheme, textTheme),
              _buildProgressSection(colorScheme, textTheme),
              _buildDateSection(colorScheme, textTheme),
              _buildTitleSection(colorScheme, textTheme),
              _buildLabelSection(colorScheme, textTheme),
              _buildDescriptionSection(colorScheme, textTheme),
              _buildSubtasksSection(colorScheme, textTheme),
              _buildAssigneeSection(colorScheme, textTheme),
              _buildAttachmentsSection(colorScheme, textTheme),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.only(
        top: 36,
        left: 16,
        right: 16,
        bottom: 36,
      ),
      // color: Colors.blue,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Icon(Icons.arrow_back_ios_new,
                  color: colorScheme.primary, size: 16),
            ),
          ),
          // const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("UI Design",
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          // const Spacer(),
          GestureDetector(
            onTap: () => _showDeleteTaskDialog(),
            child: Icon(Icons.delete_outline,
                color: colorScheme.onPrimary, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Task Progress", colorScheme, textTheme),
              _buildLabel(
                  "${(progressValue * 100).toInt()}%", colorScheme, textTheme),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: colorScheme.primary.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: _buildLabel("Start", colorScheme, textTheme)),
                  _buildEditIcon(colorScheme, () => _selectDate(true)),
                ]
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _selectDate(true),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.blue, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM-dd-yyyy').format(startDate),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: _buildLabel("Ends", colorScheme, textTheme)),
                  _buildEditIcon(colorScheme, () => _selectDate(false)),
                ]
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _selectDate(false),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.blue, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM-dd-yyyy').format(endDate),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildTitleSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Title", colorScheme, textTheme),
              GestureDetector(
                onTap: () => _editTitle(),
                child: _buildEditIcon(colorScheme, ()=> _editTitle()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCustomContainer(text: taskTitle, colorScheme: colorScheme, textTheme: textTheme,isBorderEnabled: true,),
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: colorScheme.primary),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(child: Text(taskTitle,style: const TextStyle(color: Colors.black),),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildLabelSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Labels", colorScheme, textTheme),
              GestureDetector(
                onTap: () => _editLabels(),
                child: _buildEditIcon(colorScheme, () => _editLabels()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                priority,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(
      ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Description", colorScheme, textTheme),
              GestureDetector(
                onTap: () => _editDescription(),
                child: _buildEditIcon(colorScheme, () => _editDescription()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCustomContainer(text: description, colorScheme: colorScheme, textTheme: textTheme,bgColor: colorScheme.primary.withOpacity(0.1)),
        ],
      ),
    );
  }

  bool _showSubtaskInput = false;

  Widget _buildSubtasksSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Subtasks", colorScheme, textTheme),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showSubtaskInput = !_showSubtaskInput;
                  });
                },
                child: Icon(Icons.add_circle_outline,
                    color: colorScheme.primary, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Subtasks List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subtasks.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: subtasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          subtasks[index].isCompleted = value!;
                          _updateProgress();
                        });
                      },
                      activeColor: colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        subtasks[index].title,
                        style: TextStyle(
                          decoration: subtasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    _buildEditIcon(colorScheme, () => _editSubtask(index)),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red, size: 20),
                      onPressed: () => _deleteSubtask(index),
                    ),
                  ],
                ),
              );
            },
          ),

          if (_showSubtaskInput) ...[
            TextField(
              controller: newSubtaskController,
              decoration: InputDecoration(
                hintText: "Enter new subtask",
                hintStyle: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.1)),
                ),
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (newSubtaskController.text.isNotEmpty) {
                      setState(() {
                        subtasks.add(SubTask(
                          title: newSubtaskController.text,
                          isCompleted: false,
                        ));
                        newSubtaskController.clear();
                        _updateProgress();
                        _showSubtaskInput = false;
                      });
                    }
                  },
                ),
                fillColor: colorScheme.primary.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
            ),
          ],
        ],
      ),
    );
  }



  Widget _buildAssigneeSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Assignees", colorScheme, textTheme),
              GestureDetector(
                onTap: () => _editAssignee(),
                child: _buildEditIcon(colorScheme, () => _editAssignee()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCustomContainer(text: assignee, colorScheme: colorScheme, textTheme: textTheme,isBorderEnabled: true),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection(
      ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Attachments", colorScheme, textTheme),
          const SizedBox(height: 8),
          Row(
            children: attachments
                .map(
                  (attachment) => Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.insert_drive_file_outlined,
                              color: Colors.black45),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          attachment.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomContainer({
    required String text,
    Color bgColor = Colors.transparent,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    isBorderEnabled = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: isBorderEnabled
            ? Border.all(color: colorScheme.primary)
            : null,
      ),
      child: Row(
        children: [
          Expanded(child: Text(text,style: TextStyle(color:colorScheme.onSecondaryContainer),),),
        ],
      ),
    );
  }

  Widget _buildLabel(
      String label, ColorScheme colorScheme, TextTheme textTheme) {
    return Text(label,
        style: textTheme.titleMedium?.copyWith(
          color: colorScheme.primary,
        ));
  }

  Widget _buildEditIcon(ColorScheme colorScheme,onEdit) {
    return GestureDetector(
      onTap: () {
        onEdit();
        // Edit dates
      },
      child: Icon(Icons.edit, color: colorScheme.primary, size: 20),
    );
  }

  Future<void> _selectDate(bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _editTitle() {
    _showEditDialog("Edit Title", taskTitle, (value) {
      setState(() {
        taskTitle = value;
      });
    });
  }

  void _editLabels() {
    _showEditDialog("Edit Priority", priority, (value) {
      setState(() {
        priority = value;
      });
    });
  }

  void _editDescription() {
    _showEditDialog("Edit Description", description, (value) {
      setState(() {
        description = value;
      });
    }, multiline: true);
  }

  void _editAssignee() {
    _showEditDialog("Edit Assignee", assignee, (value) {
      setState(() {
        assignee = value;
      });
    });
  }

  void _editSubtask(int index) {
    _showEditDialog("Edit Subtask", subtasks[index].title, (value) {
      setState(() {
        subtasks[index].title = value;
      });
    });
  }

  void _deleteSubtask(int index) {
    setState(() {
      subtasks.removeAt(index);
      _updateProgress();
    });
  }

  void _showDeleteTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle delete task action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task deleted")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
      String title, String initialValue, Function(String) onSave,
      {bool multiline = false}) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            maxLines: multiline ? 5 : 1,
            decoration: InputDecoration(
              hintText: "Enter $title",
              border: const OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProgress() {
    if (subtasks.isEmpty) {
      setState(() {
        progressValue = 0.0;
      });
      return;
    }

    int completed = subtasks.where((task) => task.isCompleted).length;
    setState(() {
      progressValue = completed / subtasks.length;
    });
  }
}

class SubTask {
  String title;
  bool isCompleted;
  SubTask({required this.title, required this.isCompleted});
}

class Attachment {
  final String name;
  Attachment({required this.name});
}
