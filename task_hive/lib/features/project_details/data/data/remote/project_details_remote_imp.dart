import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_hive/features/project_details/data/data/remote/project_details_remote.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/services/auth_service/auth_service.dart';

class ProjectDetailsRemoteImp implements ProjectDetailsRemote {
  final SupabaseClient supabaseClient;
  ProjectDetailsRemoteImp({SupabaseClient? supabaseClient})
      : supabaseClient =
            supabaseClient ?? getIt<AuthService>().getSupabaseClient();
  @override
  Future<int?> createTask(Map<String, dynamic> task) async {
    final response =
        await supabaseClient.from('tasks').insert(task).select('id').single();

    if (response.isEmpty) {
      throw Exception('Failed to create task');
    }

    final createdTaskId = response['id'];
    return createdTaskId;
  }

  @override
  Future<List<Map<String, dynamic>>> uploadFiles(List<File> files) async {
    final List<Map<String, dynamic>> uploadedFiles = [];
    for (final file in files) {
      final fileName = file.path.split('/').last;
      try {
        final response = await supabaseClient.storage
            .from('attachments')
            .upload(fileName, file);
        if (response.isNotEmpty) {
          final publicUrl = supabaseClient.storage
              .from('attachments') // Replace with your bucket name
              .getPublicUrl(fileName);
          uploadedFiles.add(
            {'fileName': fileName, 'url': publicUrl},
          );
        } else {
          throw Exception('Failed to upload file');
        }
      } catch (e) {
        throw Exception('Error uploading file: $e');
      }
    }
    return uploadedFiles;
  }

  @override
  Future<void> addTaskLabel(Map<String, dynamic> taskLabel) {
    // TODO: implement addTaskLabel
    throw UnimplementedError();
  }

  @override
  Future<void> assignTaskMember(Map<String, dynamic> taskMember) async {
    await supabaseClient.from('task_assignments').insert(taskMember);
  }

  @override
  Future<void> createSubTask(Map<String, dynamic> subTask) async {
    await supabaseClient.from('subtasks').insert(subTask);
  }

  @override
  Future<void> addAttachment(Map<String, dynamic> attachment) async {
    await supabaseClient.from('attachments').insert(attachment);
  }
}
