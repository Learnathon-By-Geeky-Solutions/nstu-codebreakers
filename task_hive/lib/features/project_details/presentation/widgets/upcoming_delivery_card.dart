import 'package:flutter/material.dart';
import 'package:task_hive/core/extensions/app_extension.dart';

class UpcomingDeliveryCard extends StatelessWidget {
  final String? taskName;

  final String? dueDate;
  final String? progressPercentage;
  final String? label;
  final String? priority;

  const UpcomingDeliveryCard(
      {super.key,
      this.taskName,
      this.dueDate,
      this.progressPercentage,
      this.label,
      this.priority});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: getBgColorFromPriority(priority ?? 'N/A'),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: getPriorityColor(priority ?? 'N/A'),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  priority ?? 'N/A',
                  style: textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$progressPercentage%',
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            taskName ?? 'No Task Name',
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Label: ${label ?? 'N/A'}',
            style: textTheme.textSmRegular.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Due Date: ',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: dueDate,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Colors.red.shade600;
    case 'medium':
      return Colors.orange.shade600;
    case 'low':
      return Colors.green.shade600;
    default:
      return Colors.grey.shade600;
  }
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
