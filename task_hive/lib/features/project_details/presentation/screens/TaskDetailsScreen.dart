import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_hive/core/di/di.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/features/project_details/domain/entity/assignee_entity.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/presentation/cubits/create_task/create_task_cubit.dart';

import '../../../../core/base/app_data/app_data.dart';
import '../../../../core/navigation/routes.dart';
import '../../domain/entity/sub_task_entity.dart';
import '../cubits/create_task/create_task_state.dart';
import '../cubits/delete_task/detele_task_cubit.dart';
import '../cubits/fetch_task/fetch_task_cubit.dart';

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
  String priority = "High";
  String description =
      "user interface (UI) is anything a user may interact with to use a digital product or service. This includes everything from screens and touchscreens, keyboards, sounds, and even lights. To understand the evolution of UI, however, it's helpful to learn a bit more about its history and how it has evolved into best practices and a profession.";
  String assignee = "Tahsin";
  List<AssigneeEntity> assignees = [];
  String taskLabel = "Design";
  String taskStatus = "To Do";
  bool edited = false;

  List<SubTask> subtasks = [
    SubTask(title: "UI Design", isCompleted: true),
    SubTask(title: "UI Design", isCompleted: true),
    SubTask(title: "UI Design", isCompleted: true),
    SubTask(title: "UI Design", isCompleted: false),
  ];

  List<String> labels = ['Bug', 'Feature', 'Documentation', 'Enhancement'];
  List<String> priorities = ['High', 'Medium', 'Low'];
  List<String> statuses = ['To Do', 'In Progress', 'Done'];
  List<Attachment> attachments = [];

  TextEditingController newSubtaskController = TextEditingController();
  final _appData = getIt<AppData>();
  final _fetchTaskCubit = getIt<FetchTaskCubit>();
  final _createTaskCubit = getIt<CreateTaskCubit>();
  final _deleteTaskCubit = getIt<DeleteTaskCubit>();

  @override
  void dispose() {
    newSubtaskController.dispose();
    _fetchTaskCubit.close();
    _createTaskCubit.close();
    _deleteTaskCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _callFetchTaskCubit();
    _createTaskCubit.stream.listen((state) {
      if (state is CreateTaskSuccessState) {
        _callFetchTaskCubit();
      }
      if (state is CreateTaskErrorState && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.failure.message)),
        );
      }
    });
    _deleteTaskCubit.stream.listen((state) {
      if (state is DeleteTaskSuccess && mounted) {
        context.go(MyRoutes.projectDetails);
      }
      if (state is DeleteTaskFailure && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.failure.message)),
        );
      }
    });
    super.initState();
  }

  void _callFetchTaskCubit() {
    _fetchTaskCubit.fetchTask(_appData.currentTaskId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: (edited == true)
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  edited = false;
                });
                _createTaskCubit.createTask(TaskEntity(
                  projectId: _appData.currentProjectId,
                  taskId: _appData.currentTaskId,
                  userId: _appData.userId,
                  title: taskTitle,
                  description: description,
                  priority: priority,
                  createdAt: startDate,
                  updatedAt: DateTime.now(),
                  dueDate: endDate,
                  subTasks: subtasks,
                  assignees: assignees,
                  label: taskLabel,
                  status: taskStatus,
                ));
              },
              child: const Icon(Icons.done),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<FetchTaskCubit, FetchTaskState>(
            bloc: _fetchTaskCubit,
            listener: (context, state) {
              if (state is FetchTaskSuccessState) {
                setState(() {
                  taskTitle = state.task.title ?? 'N/A';
                  priority = state.task.priority ?? 'N/A';
                  description = state.task.description ?? 'N/A';
                  startDate = state.task.createdAt ?? DateTime.now();
                  endDate = state.task.dueDate ?? DateTime.now();
                  progressValue = _getProgressValue(state.task.subTasks ?? []);
                  subtasks = (state.task.subTasks ?? []);
                  assignees = (state.task.assignees ?? []);
                  taskLabel = state.task.label ?? 'N/A';
                  attachments = state.task.attachmentUrls
                          ?.map((e) =>
                              Attachment(name: e.split('/').last, url: e))
                          .toList() ??
                      [];
                });
              }
              if (state is FetchTaskErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failure.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is FetchTaskLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(colorScheme, textTheme),
                  _buildProgressSection(colorScheme, textTheme),
                  _buildDateSection(colorScheme, textTheme),
                  _buildTitleSection(colorScheme, textTheme),
                  _buildDescriptionSection(colorScheme, textTheme),
                  _buildStatusSection(colorScheme, textTheme),
                  _buildLabelSection(colorScheme, textTheme),
                  _buildPrioritySection(colorScheme, textTheme),
                  _buildSubtasksSection(colorScheme, textTheme),
                  _buildAssigneeSection(colorScheme, textTheme),
                  _buildAttachmentsSection(colorScheme, textTheme),
                  const SizedBox(height: 20),
                ],
              );
            },
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
              child: Icon(Icons.arrow_back_ios_new,
                  color: colorScheme.primary, size: 16),
            ),
          ),
          // const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(taskTitle,
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
            child: BlocBuilder<DeleteTaskCubit, DeleteTaskState>(
              bloc: _deleteTaskCubit,
              builder: (context, state) {
                if (state is DeleteTaskLoading) {
                  return const CircularProgressIndicator();
                }
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.delete_outline,
                      color: colorScheme.primary, size: 16),
                );
              },
            ),
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
                ]),
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
                ]),
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
                child: _buildEditIcon(colorScheme, () => _editTitle()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCustomContainer(
            text: taskTitle,
            colorScheme: colorScheme,
            textTheme: textTheme,
            isBorderEnabled: true,
          ),
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

  Widget _buildStatusSection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Status", colorScheme, textTheme),
              GestureDetector(
                onTap: () => _editLabels(),
                child: _buildEditIcon(colorScheme, () => _editStatus()),
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
                taskStatus,
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

  Widget _buildLabelSection(ColorScheme colorScheme, TextTheme textTheme) {
    //TODO
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
                taskLabel,
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

  Widget _buildPrioritySection(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Priority", colorScheme, textTheme),
              GestureDetector(
                onTap: () => _editLabels(),
                child: _buildEditIcon(colorScheme, () => _editPriority()),
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
          _buildCustomContainer(
              text: description,
              colorScheme: colorScheme,
              textTheme: textTheme,
              bgColor: colorScheme.primary.withOpacity(0.1)),
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
                  borderSide:
                      BorderSide(color: colorScheme.primary.withOpacity(0.1)),
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
                        edited = true;
                      });
                    }
                  },
                ),
                fillColor: colorScheme.primary.withOpacity(0.1),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                child: Icon(
                  Icons.add_circle_outline,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // _buildCustomContainer(
          //     text: assignee,
          //     colorScheme: colorScheme,
          //     textTheme: textTheme,
          //     isBorderEnabled: true),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assignees.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person, color: colorScheme.primary),
                    ),
                    Expanded(
                      child: Text(
                        assignees[index].name ?? assignees[index].id.toString(),
                        style: textTheme.textSmRegular.copyWith(
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red, size: 20),
                      onPressed: () {
                        setState(() {
                          edited = true;
                          assignees.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
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
        border: isBorderEnabled ? Border.all(color: colorScheme.primary) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
          ),
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

  Widget _buildEditIcon(ColorScheme colorScheme, onEdit) {
    return GestureDetector(
      onTap: () {
        onEdit();

        // Edit dates
      },
      child: Icon(Icons.edit, color: colorScheme.primary, size: 20),
    );
  }

  Future<void> _selectDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        edited = true;
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _editTitle() {
    _showEditDialog("Edit Title", taskTitle, null, (value) {
      setState(() {
        edited = true;
        taskTitle = value;
      });
    });
  }

  void _editStatus() {
    _showEditDialog("Edit Status", taskStatus, statuses.toSet().toList(),
        (value) {
      setState(() {
        edited = true;
        taskStatus = value;
      });
    });
  }

  void _editLabels() {
    _showEditDialog("Edit Priority", taskLabel, labels.toSet().toList(),
        (value) {
      setState(() {
        edited = true;
        taskLabel = value;
      });
    });
  }

  void _editPriority() {
    _showEditDialog("Edit Priority", priority, priorities.toSet().toList(),
        (value) {
      setState(() {
        edited = true;
        priority = value;
      });
    });
  }

  void _editDescription() {
    _showEditDialog("Edit Description", description, null, (value) {
      setState(() {
        edited = true;
        description = value;
      });
    }, multiline: true);
  }

  void _editAssignee() {
    _showEditDialog("Edit Assignee", assignee, null, (value) {
      setState(() {
        edited = true;
        assignee = value;
      });
    });
  }

  void _editSubtask(int index) {
    _showEditDialog("Edit Subtask", subtasks[index].title, null, (value) {
      setState(() {
        edited = true;
        subtasks[index].title = value;
      });
    });
  }

  void _deleteSubtask(int index) {
    setState(() {
      edited = true;
      final newSubTasks =
          subtasks.where((task) => subtasks.indexOf(task) != index).toList();
      subtasks = newSubTasks;
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
                _deleteTaskCubit.deleteTask(_appData.currentTaskId ?? 0);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(String title, String initialValue, List<String>? options,
      Function(String) onSave,
      {bool multiline = false}) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: (options != null)
              ? DropdownButtonFormField<String>(
                  value: initialValue,
                  items: options
                      .map((option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.text = value ?? '';
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              : TextField(
                  //TODO: implement option selection
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

  double _getProgressValue(List<SubTask> list) {
    if (list.isEmpty) {
      return 0.0;
    }
    int completed = list.where((task) => task.isCompleted).length;
    return completed / list.length;
  }
}

class Attachment {
  final String name;
  final String url;
  Attachment({required this.name, required this.url});
}
