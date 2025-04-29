import 'package:dartz/dartz.dart';
import 'package:task_hive/core/base/use_case/base_use_case.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';

import '../../../../core/io/failure.dart';

class CreateTaskUseCase extends BaseUseCase<TaskEntity, Failure, int> {
  final ProjectDetailsRepo _projectDetailsRepo;
  CreateTaskUseCase(this._projectDetailsRepo);
  @override
  Future<Either<Failure, int>> call(TaskEntity input) {
    return _projectDetailsRepo.createTask(input);
  }
}

class FetchTaskUseCase extends BaseUseCase<int, Failure, TaskEntity> {
  final ProjectDetailsRepo _projectDetailsRepo;
  FetchTaskUseCase(this._projectDetailsRepo);
  @override
  Future<Either<Failure, TaskEntity>> call(int input) async {
    return await _projectDetailsRepo.fetchTask(input);
  }
}

class FetchTasksUseCase extends BaseUseCase<int, Failure, List<TaskEntity>> {
  final ProjectDetailsRepo _projectDetailsRepo;
  FetchTasksUseCase(this._projectDetailsRepo);
  @override
  Future<Either<Failure, List<TaskEntity>>> call(int input) {
    return _projectDetailsRepo.fetchTasks(input);
  }
}

class DeleteTasksUseCase extends BaseUseCase<int, Failure, Success> {
  final ProjectDetailsRepo _projectDetailsRepo;
  DeleteTasksUseCase(this._projectDetailsRepo);
  @override
  Future<Either<Failure, Success>> call(int input) async {
    return await _projectDetailsRepo.deleteTask(input);
  }
}
