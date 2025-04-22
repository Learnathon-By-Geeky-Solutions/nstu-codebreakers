import 'dart:io';

class TaskEntity {
  int? projectId;
  int? userId;
  String? status;
  String? title;
  String? description;
  List<String>? subTasks;
  DateTime? dueDate;
  String? priority;
  String? label;
  int? createdBy;
  List<int>? assigneeIds;
  List<File>? attachments;
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
  });

  TaskEntity.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    dueDate = DateTime.tryParse(json['due_date'] ?? '');
    priority = json['priority'];
    createdBy = json['created_by'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
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
