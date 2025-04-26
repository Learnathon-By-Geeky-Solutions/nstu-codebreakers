import 'dart:io';

import 'package:task_hive/features/project_details/domain/entity/assignee_entity.dart';

import 'sub_task_entity.dart';

class TaskEntity {
  int? projectId;
  int? userId;
  int? taskId;
  String? status;
  String? title;
  String? description;
  List<SubTask>? subTasks;
  DateTime? dueDate;
  String? priority;
  String? label;
  int? createdBy;
  List<int>? assigneeIds;
  List<AssigneeEntity>? assignees;
  List<File>? attachments;
  List<String>? attachmentUrls;
  DateTime? createdAt, updatedAt;

  TaskEntity({
    this.projectId,
    this.userId,
    this.status,
    this.title,
    this.description,
    this.subTasks,
    this.dueDate,
    this.priority,
    this.label,
    this.assigneeIds,
    this.attachments,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.assignees,
    this.attachmentUrls,
    this.taskId,
  });

  TaskEntity.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    status = json['status'];
    label = json['label'];
    title = json['title'];
    description = json['description'];
    dueDate = DateTime.tryParse(json['due_date'] ?? '');
    priority = json['priority'];
    taskId = json['id'];
    createdBy = json['created_by'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    assignees = (json['assignees'] as List?)
        ?.map((e) => AssigneeEntity(
              id: e['user_id'],
              name: e['name'],
            ))
        .toList();
    attachmentUrls = (json['attachments'] as List?)
        ?.map((e) => e['file_path'] as String)
        .toList();

    subTasks = (json['subtasks'] as List?)
        ?.map((e) => SubTask(title: e['title'], isCompleted: e['status']))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'title': title,
      'description': description,
      'due_date': dueDate?.toIso8601String(),
      'priority': priority,
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'project_id': projectId,
      'label': label,
    };
  }
}
