import 'package:dartz/dartz.dart';
import 'package:task_hive/core/base/use_case/base_use_case.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';

class CreateTaskUseCase extends BaseUseCase<TaskEntity, Success, Failure> {
  final ProjectDetailsRepo _projectDetailsRepo;
  CreateTaskUseCase(this._projectDetailsRepo);
  @override
  Future<Either<Success, Failure>> call(TaskEntity input) {
    return _projectDetailsRepo.createTask(input);
  }
}
