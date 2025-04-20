import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entity/task_entity.dart';

abstract class ProjectDetailsRepo {
  Future<Either<Success, Failure>> createTask(TaskEntity task);
}
