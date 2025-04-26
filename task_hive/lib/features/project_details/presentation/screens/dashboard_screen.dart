import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/di/di.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/features/project_details/presentation/widgets/priority_task_card.dart';
import 'package:task_hive/features/project_details/presentation/widgets/upcoming_delivery_card.dart';
import 'package:task_hive/features/project_details/domain/entity/sub_task_entity.dart';
import 'package:task_hive/features/project_details/presentation/cubits/fetch_tasks/fetch_tasks_cubit.dart';

import '../../../../core/base/app_data/app_data.dart';
import '../../../../core/navigation/routes.dart';
import '../../../home/domain/entity/project_info.dart';
import '../cubits/fetch_tasks/fetch_tasks_state.dart';

class ProjectDetailsScreen extends StatefulWidget {
  // final Map<String, dynamic> keyData;
  // const ProjectDetailsScreen({super.key, required this.keyData});
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  // int _selectedIndex = 0;
  late final String userName;
  late final int projectId;
  final _appData = getIt<AppData>();
  final _fetchTasks = getIt<FetchTasksCubit>();
  final colors = [Colors.blue, Colors.deepPurple, Colors.deepOrange];
  final icons = [Icons.design_services, Icons.code, Icons.edit_document];
  // Sample delivery task data
  final List<ProjectData> _deliveryTasks = [
    ProjectData(
        title: 'Package #1452',
        address: '123 Main Street, Apt 4B',
        date: DateTime.now().add(const Duration(days: 1)),
        status: 'In Transit',
        assignee: ['Tahsin', 'Mamun', 'Rafi'],
        priority: 'High',
        percentage: 50),
    ProjectData(
      title: 'Package #2378',
      address: '456 Oak Avenue',
      date: DateTime.now().add(const Duration(days: 2)),
      status: 'Processing',
      assignee: ['Tahsin', 'Mamun', 'Rafi'],
      priority: 'Low',
      percentage: 30,
    ),
    ProjectData(
        title: 'Package #3912',
        address: '789 Pine Road',
        date: DateTime.now().add(const Duration(days: 3)),
        status: 'Scheduled',
        assignee: ['Tahsin', 'Mamun', 'Rafi'],
        priority: 'Medium',
        percentage: 60)
  ];

  @override
  void initState() {
    if (_appData.currentProjectId != null) {
      _fetchTasks.fetchTasks(_appData.currentProjectId!);
    }
    userName = _appData.userName ?? 'No name';
    projectId = _appData.currentProjectId ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    _fetchTasks.close();
    super.dispose();
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = _formatDate(now);

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          onPressed: () {
            context.go(
              "${MyRoutes.home}/${MyRoutes.projectDetails}/${MyRoutes.createTask}",
              // extra: {
              //   'project_id': _appData.currentProjectId,
              //   'user_id': _appData.userId,
              // },
            );
          },
          icon: Icon(Icons.add, color: colorScheme.surface),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Welcome message
              Text(
                'Have a nice day!',
                style: textTheme.textxlMedium,
              ),
              Text(
                userName,
                style: textTheme.textSmMedium.copyWith(
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(height: 20),

              Text('Upcoming Deliveries', style: textTheme.headlineMedium),
              const SizedBox(height: 15),

              SizedBox(
                height: 170,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  BlocBuilder<FetchTasksCubit, FetchTasksState>(
                    bloc: _fetchTasks,
                    builder: (context, state) {
                      if (state is FetchTasksSuccessState) {
                        int ind = 0;
                        final tasks = [...state.tasks]..sort(
                            (a, b) => a.dueDate!.compareTo(b.dueDate!),
                          );
                        return Row(
                          children: tasks.map((task) {
                            return GestureDetector(
                              onTap: () {
                                _appData.currentTaskId = task.taskId;
                                context.go(
                                  "${MyRoutes.home}/${MyRoutes.projectDetails}/${MyRoutes.createTask}/${MyRoutes.taskDetails}",
                                );
                              },
                              child: priorityTaskCard(
                                color:
                                    getBgColorFromPriority(task.priority ?? ''),
                                icon: icons[ind++ % 3],
                                title: task.title ?? 'N/A',
                                progress: double.tryParse(
                                        _getProgress(task.subTasks ?? [])) ??
                                    0.0,
                                days: _getRemainDays(
                                    task.dueDate ?? DateTime.now()),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (state is FetchTasksLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FetchTasksErrorState) {
                        return Text(state.failure.message);
                      }
                      return const Center(child: Text('No tasks available.'));
                    },
                  ),
                ]),
              ),

              const SizedBox(height: 20),

              // Delivery tasks section
              Text(
                'My Priority Task',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 15),

              // Delivery task cards - Scrollable
              BlocBuilder<FetchTasksCubit, FetchTasksState>(
                bloc: _fetchTasks,
                builder: (context, state) {
                  if (state is FetchTasksLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is FetchTasksErrorState) {
                    return Text(state.failure.message);
                  }
                  if (state is FetchTasksSuccessState) {
                    final level1Tasks = state.tasks
                        .where((task) => task.priority == 'High')
                        .toList();
                    final level2Tasks = state.tasks
                        .where((task) => task.priority == 'Medium')
                        .toList();
                    final level3Tasks = state.tasks
                        .where((task) => task.priority == 'Low')
                        .toList();
                    final tasks = [
                      ...level1Tasks,
                      ...level2Tasks,
                      ...level3Tasks
                    ];
                    if (tasks.isEmpty) {
                      return const Center(child: Text('No tasks available.'));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _appData.currentTaskId = tasks[index].taskId;
                                  context.go(
                                    "${MyRoutes.home}/${MyRoutes.projectDetails}/${MyRoutes.createTask}/${MyRoutes.taskDetails}",
                                  );
                                },
                                child: UpcomingDeliveryCard(
                                  taskName:
                                      tasks[index].title ?? 'Untitled Task',
                                  // timeRange: _deliveryTasks[index].date.toString(),
                                  dueDate: _formatDate(
                                      tasks[index].dueDate ?? DateTime.now()),
                                  label: tasks[index].label,
                                  progressPercentage:
                                      _getProgress(tasks[index].subTasks ?? []),
                                  // assignees: _deliveryTasks[index].assignee,
                                  priority: tasks[index].priority ?? 'N/A',
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                          // return _buildDeliveryTaskCard(_deliveryTasks[index]);
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getBgColorFromPriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.deepPurple;
      case 'medium':
        return Colors.deepOrange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getProgress(List<SubTask> subTasks) {
    if (subTasks.isEmpty) {
      return '0';
    }
    int completed = subTasks.where((task) => task.isCompleted).length;
    double rate = (completed / subTasks.length) * 100;
    return rate.toStringAsFixed(1);
  }

  _getRemainDays(DateTime date) {
    return date.difference(DateTime.now()).inDays;
  }
}

String _formatDate(DateTime date) {
  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final weekday = weekdays[date.weekday - 1]; // weekday is 1-7
  final month = months[date.month - 1]; // month is 1-12

  return '$weekday, $month ${date.day} ${date.year}';
}

// Model class for Delivery Tasks

/**
 * [
                      priorityTaskCard(
                        color: Colors.blue,
                        icon: Icons.design_services,
                        title: 'UI Design',
                        days: 10,
                        progress: 0.8,
                      ),
                      priorityTaskCard(
                        color: Colors.deepPurple,
                        icon: Icons.code,
                        title: 'Laravel Task',
                        days: 20,
                        progress: 0.3,
                      ),
                      priorityTaskCard(
                        color: Colors.red,
                        icon: Icons.image,
                        title: 'Edit Pictures',
                        days: 5,
                        progress: 0.6,
                      ),
                    ],
 */