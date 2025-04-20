import 'dart:io';

abstract class ProjectDetailsRemote {
  Future<void> createTask(Map<String, dynamic> task);
  Future<List<Map<String, dynamic>>> uploadFiles(List<File> files);
  Future<void> createSubTask(Map<String, dynamic> task);
  Future<void> assignTaskMember(Map<String, dynamic> taskMember);
  Future<void> addTaskLabel(Map<String, dynamic> taskLabel);
}
