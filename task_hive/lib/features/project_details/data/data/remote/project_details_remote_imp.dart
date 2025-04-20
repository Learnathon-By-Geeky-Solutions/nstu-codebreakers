import 'dart:io';

import 'package:task_hive/features/project_details/data/data/remote/project_details_remote.dart';

class ProjectDetailsRemoteImp implements ProjectDetailsRemote {
  @override
  Future<void> createTask(Map<String, dynamic> task) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> uploadFiles(List<File> files) {
    // TODO: implement uploadFiles
    throw UnimplementedError();
  }

  @override
  Future<void> addTaskLabel(Map<String, dynamic> taskLabel) {
    // TODO: implement addTaskLabel
    throw UnimplementedError();
  }

  @override
  Future<void> assignTaskMember(Map<String, dynamic> taskMember) {
    // TODO: implement assignTaskMember
    throw UnimplementedError();
  }

  @override
  Future<void> createSubTask(Map<String, dynamic> task) {
    // TODO: implement createSubTask
    throw UnimplementedError();
  }
}
