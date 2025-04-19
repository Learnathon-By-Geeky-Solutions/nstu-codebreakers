import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/features/auth/presentation/screens/forget_pass_screen.dart';
import 'package:task_hive/features/home/presentation/widgets/priority_task_card.dart';
import 'package:task_hive/features/home/presentation/widgets/upcoming_delivery_card.dart';

import '../../../../core/navigation/routes.dart';
import '../../../home/domain/entities/project_entity.dart';
import '../../../home/domain/entity/project_info.dart';
// import 'package:intl/intl.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> keyData;
  const ProjectDetailsScreen({super.key, required this.keyData});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _selectedIndex = 0;
  late final String userName;
  late final int projectId;
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
    super.initState();
    userName = widget.keyData['user_name'] ?? 'No name';
    projectId = widget.keyData['project_id'] ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                  extra: {
                    'project_id': widget.keyData['project_id'],
                    'user_id': widget.keyData['user_id'],
                  });
            },
            icon: Icon(Icons.add, color: colorScheme.surface),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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

                // Priority tasks section
                Text('My Priority Task', style: textTheme.headlineMedium),
                const SizedBox(height: 15),

                // Priority task cards
                SizedBox(
                  height: 170,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
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
                  ),
                ),

                const SizedBox(height: 20),

                // Delivery tasks section
                Text(
                  'Upcoming Deliveries',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 15),

                // Delivery task cards - Scrollable
                Expanded(
                  child: ListView.builder(
                    itemCount: _deliveryTasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UpcomingDeliveryCard(
                            taskName: _deliveryTasks[index].title,
                            // timeRange: _deliveryTasks[index].date.toString(),
                            dueDate: _deliveryTasks[index].date.toString(),
                            progressPercentage:
                                _deliveryTasks[index].percentage,
                            assignees: _deliveryTasks[index].assignee,
                            priority: _deliveryTasks[index].priority,
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                      // return _buildDeliveryTaskCard(_deliveryTasks[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
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
