import 'package:dartz/dartz.dart';
import 'package:task_hive/core/base/use_case/base_use_case.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';

import '../../../../core/io/failure.dart';

class CreateTaskUseCase extends BaseUseCase<TaskEntity, int, Failure> {
  final ProjectDetailsRepo _projectDetailsRepo;
  CreateTaskUseCase(this._projectDetailsRepo);
  @override
  Future<Either<int, Failure>> call(TaskEntity input) {
    return _projectDetailsRepo.createTask(input);
  }
}

class FetchTaskUseCase extends BaseUseCase<int, TaskEntity, Failure> {
  final ProjectDetailsRepo _projectDetailsRepo;
  FetchTaskUseCase(this._projectDetailsRepo);
  @override
  Future<Either<TaskEntity, Failure>> call(int input) async {
    return await _projectDetailsRepo.fetchTask(input);
  }
}

class FetchTasksUseCase extends BaseUseCase<int, List<TaskEntity>, Failure> {
  final ProjectDetailsRepo _projectDetailsRepo;
  FetchTasksUseCase(this._projectDetailsRepo);
  @override
  Future<Either<List<TaskEntity>, Failure>> call(int input) {
    return _projectDetailsRepo.fetchTasks(input);
  }
}

class DeleteTasksUseCase extends BaseUseCase<int, Success, Failure> {
  final ProjectDetailsRepo _projectDetailsRepo;
  DeleteTasksUseCase(this._projectDetailsRepo);
  @override
  Future<Either<Success, Failure>> call(int input) async {
    return await _projectDetailsRepo.deleteTask(input);
  }
}
