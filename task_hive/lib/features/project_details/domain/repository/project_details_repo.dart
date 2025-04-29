import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entity/task_entity.dart';

abstract class ProjectDetailsRepo {
  Future<Either<Failure, int>> createTask(TaskEntity task);
  Future<Either<Failure, TaskEntity>> fetchTask(int taskId);
  Future<Either<Failure, Success>> deleteTask(int taskId);
  Future<Either<Failure, List<TaskEntity>>> fetchTasks(int projectId);
}
