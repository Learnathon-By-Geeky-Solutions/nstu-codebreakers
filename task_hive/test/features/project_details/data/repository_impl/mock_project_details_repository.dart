import 'package:mocktail/mocktail.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';
import 'package:dartz/dartz.dart';

class MockProjectDetailsRepository extends Mock implements ProjectDetailsRepo {
  @override
  Future<Either<int, Failure>> createTask(TaskEntity task) async {
    return Left(1); // Return task ID 1
  }

  @override
  Future<Either<TaskEntity, Failure>> fetchTask(int taskId) async {
    if (taskId > 0) {
      return Left(TaskEntity(
        taskId: taskId,
        title: 'Test Task',
        description: 'Test Description',
        status: 'To Do',
        priority: 'High',
      ));
    }
    return Right(Failure('Task not found'));
  }

  @override
  Future<Either<List<TaskEntity>, Failure>> fetchTasks(int projectId) async {
    return Left([
      TaskEntity(
        taskId: 1,
        title: 'Task 1',
        status: 'To Do',
      ),
      TaskEntity(
        taskId: 2,
        title: 'Task 2',
        status: 'In Progress',
      ),
    ]);
  }

  @override
  Future<Either<Success, Failure>> deleteTask(int taskId) async {
    return Left(Success('Task deleted successfully'));
  }
}
