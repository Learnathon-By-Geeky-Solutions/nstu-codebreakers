import 'dart:io';

abstract class ProjectDetailsRemote {
  Future<int?> createTask(Map<String, dynamic> task);
  Future<List<Map<String, dynamic>>> uploadFiles(List<File> files);
  Future<void> createSubTask(Map<String, dynamic> subTask);
  Future<void> assignTaskMember(Map<String, dynamic> taskMember);
  Future<void> addTaskLabel(Map<String, dynamic> taskLabel);
  Future<void> addAttachment(Map<String, dynamic> attachment);
  Future<Map<String, dynamic>> fetchTask(int taskId);
}
