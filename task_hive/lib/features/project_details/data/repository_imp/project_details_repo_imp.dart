import 'package:dartz/dartz.dart';
import 'package:task_hive/core/base/app_data/app_data.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/data/data/remote/project_details_remote_imp.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';
import 'package:task_hive/features/project_details/presentation/screens/task_create_screen.dart';

import '../../../../core/di/di.dart';
import '../data/remote/project_details_remote.dart';

class ProjectDetailsRepoImp implements ProjectDetailsRepo {
  ProjectDetailsRemote _projectDetailsRemote;
  ProjectDetailsRepoImp(this._projectDetailsRemote);
  @override
  Future<Either<int, Failure>> createTask(TaskEntity task) async {
    try {
      final filePaths =
          await _projectDetailsRemote.uploadFiles(task.attachments ?? []);

      final taskId = await _projectDetailsRemote.createTask(task.toJson());
      final userId = task.userId ?? 0;

      for (final element in filePaths) {
        await _projectDetailsRemote.addAttachment({
          'task_id': taskId,
          'user_id': userId,
          'file_path': element['url'],
        });
      }
      if (task.subTasks != null) {
        for (final subTask in task.subTasks!) {
          await _projectDetailsRemote.createSubTask({
            'task_id': taskId,
            'title': subTask.title,
            'status': subTask.isCompleted,
          });
        }
      }
      // task.assigneeIds?.map((assigneeId) async {
      //   await _projectDetailsRemote.assignTaskMember({
      //     'task_id': taskId,
      //     'user_id': assigneeId,
      //   });
      // });
      if (task.assignees != null) {
        for (final assignee in task.assignees!) {
          await _projectDetailsRemote.assignTaskMember({
            'task_id': taskId,
            'user_id': assignee.id,
          });
        }
      }
      if (taskId == null) {
        throw Exception('Task not created');
      }
      return Left(taskId);
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<TaskEntity, Failure>> fetchTask(int? taskId) async {
    try {
      final res = await _projectDetailsRemote.fetchTask(taskId ?? 0);
      print('dbg res: $res');
      final task = TaskEntity.fromJson(res);
      return Left(task);
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }
}
