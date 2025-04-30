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
    if (task.containsKey('id') && task['id'] != null) {
      final taskId = task['id'];

      // Update the task by performing an upsert operation
      final response =
          await supabaseClient.from('tasks').upsert(task).select('id').single();

      if (response.isEmpty) {
        throw Exception('Failed to update task');
      }

      return taskId;
    }
    task.remove('id');
    final response =
        await supabaseClient.from('tasks').upsert(task).select('id').single();

    if (response.isEmpty) {
      throw Exception('Failed to create task');
    }

    return response['id'];
  }

  @override
  Future<List<Map<String, dynamic>>> uploadFiles(List<File> files) async {
    final List<Map<String, dynamic>> uploadedFiles = [];

    for (final file in files) {
      final fileName = file.path.split('/').last;

      try {
        // Check if the file already exists
        final existingFiles = await supabaseClient.storage
            .from('attachments') // Replace with your bucket name
            .list(path: '', searchOptions: SearchOptions(search: fileName));

        if (existingFiles.isNotEmpty) {
          // File exists, get its public URL
          final publicUrl = supabaseClient.storage
              .from('attachments') // Replace with your bucket name
              .getPublicUrl(fileName);

          uploadedFiles.add({'fileName': fileName, 'url': publicUrl});
        } else {
          // File does not exist, upload it
          final uploadResponse = await supabaseClient.storage
              .from('attachments') // Replace with your bucket name
              .upload(fileName, file);

          if (uploadResponse.isNotEmpty) {
            final publicUrl = supabaseClient.storage
                .from('attachments') // Replace with your bucket name
                .getPublicUrl(fileName);

            uploadedFiles.add({'fileName': fileName, 'url': publicUrl});
          } else {
            throw Exception('Failed to upload file: $fileName');
          }
        }
      } catch (e) {
        throw Exception('Error processing file "$fileName": $e');
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
    await supabaseClient.from('task_assignments').upsert(taskMember);
  }

  @override
  Future<void> createSubTask(Map<String, dynamic> subTask) async {
    final existingSubTask = await supabaseClient
        .from('subtasks')
        .select()
        .eq('title', subTask['title'])
        .eq('task_id', subTask['task_id'])
        .maybeSingle();

    if (existingSubTask == null) {
      await supabaseClient.from('subtasks').upsert(subTask);
    }
  }

  @override
  Future<void> addAttachment(Map<String, dynamic> attachment) async {
    await supabaseClient.from('attachments').upsert(attachment);
  }

  @override
  Future<Map<String, dynamic>> fetchTask(int taskId) async {
    List<Map<String, dynamic>> assigneesJson = await supabaseClient
        .from('task_assignments')
        .select()
        .eq('task_id', taskId);
    assigneesJson = await Future.wait(assigneesJson.map((e) async {
      final userName = await supabaseClient
          .from('users')
          .select('full_name')
          .eq('id', e['user_id'])
          .single();
      return {
        'user_id': e['user_id'],
        'name': userName['full_name'],
      };
    }).toList());

    final attachmentsJson =
        await supabaseClient.from('attachments').select().eq('task_id', taskId);

    final subTasksJson =
        await supabaseClient.from('subtasks').select().eq('task_id', taskId);

    Map<String, dynamic> taskJson =
        await supabaseClient.from('tasks').select().eq('id', taskId).single();
    taskJson.putIfAbsent('attachments', () => attachmentsJson);
    taskJson.putIfAbsent('assignees', () => assigneesJson);
    taskJson.putIfAbsent('subtasks', () => subTasksJson);
    return taskJson;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchTasks(int projectId) async {
    final taskIds = await supabaseClient
        .from('tasks')
        .select('id')
        .eq('project_id', projectId);
    final res = await Future.wait(taskIds.map((e) async {
      final task = await fetchTask(e['id']);
      return task;
    }).toList());
    return res;
  }

  @override
  Future<void> deleteTasks(int taskId) async {
    await supabaseClient.from('tasks').delete().eq('id', taskId);
  }

  @override
  Future<void> deleteSubTasks(int taskId) async {
    await supabaseClient.from('subtasks').delete().eq('task_id', taskId);
  }

  @override
  Future<void> deleteAssignees(int taskId) {
    return supabaseClient
        .from('task_assignments')
        .delete()
        .eq('task_id', taskId);
  }

  @override
  Future<void> deleteAttachments(int taskId) {
    // TODO: implement deleteAttachments
    throw UnimplementedError();
  }
}
