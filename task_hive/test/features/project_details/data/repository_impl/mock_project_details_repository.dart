import 'package:mocktail/mocktail.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';
import 'package:dartz/dartz.dart';

class MockProjectDetailsRepository extends Mock implements ProjectDetailsRepo {
  @override
  Future<Either<Failure, int>> createTask(TaskEntity task) async {
    return Right(1); // Return task ID 1
  }

  @override
  Future<Either<Failure, TaskEntity>> fetchTask(int taskId) async {
    if (taskId > 0) {
      return Right(TaskEntity(
        taskId: taskId,
        title: 'Test Task',
        description: 'Test Description',
        status: 'To Do',
        priority: 'High',
      ));
    }
    return Left(Failure('Task not found'));
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks(int projectId) async {
    return Right([
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
  Future<Either<Failure, Success>> deleteTask(int taskId) async {
    return Right(Success('Task deleted successfully'));
  }
}
