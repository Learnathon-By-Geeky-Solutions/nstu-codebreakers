import 'package:dartz/dartz.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/data/data/remote/project_details_remote_imp.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';
import 'package:task_hive/features/project_details/presentation/screens/task_create_screen.dart';

import '../data/remote/project_details_remote.dart';

class ProjectDetailsRepoImp implements ProjectDetailsRepo {
  ProjectDetailsRemote _projectDetailsRemote;
  ProjectDetailsRepoImp(this._projectDetailsRemote);
  @override
  Future<Either<Success, Failure>> createTask(TaskEntity task) async {
    try {
      final filePaths =
          await _projectDetailsRemote.uploadFiles(task.attachments ?? []);
      final taskId = await _projectDetailsRemote.createTask(task.toJson());
      final userId = task.userId ?? 0;
      filePaths.map((element) async {
        await _projectDetailsRemote.addAttachment({
          'task_id': taskId,
          'user_id': userId,
          'file_path': element['url'],
        });
      });
      task.subTasks?.map((subTask) async {
        await _projectDetailsRemote.createSubTask({
          'task_id': taskId,
          'title': userId,
          'status': subTask,
        });
      });
      task.assigneeIds?.map((assigneeId) async {
        await _projectDetailsRemote.assignTaskMember({
          'task_id': taskId,
          'user_id': assigneeId,
        });
      });
      return Left(Success('Task created successfully'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }
}
