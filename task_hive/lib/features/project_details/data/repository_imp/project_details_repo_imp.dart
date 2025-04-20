import 'package:dartz/dartz.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/project_details/data/data/remote/project_details_remote_imp.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';
import 'package:task_hive/features/project_details/domain/repository/project_details_repo.dart';

import '../data/remote/project_details_remote.dart';

class ProjectDetailsRepoImp implements ProjectDetailsRepo {
  ProjectDetailsRemote _projectDetailsRemote;
  ProjectDetailsRepoImp(this._projectDetailsRemote);
  @override
  Future<Either<Success, Failure>> createTask(TaskEntity task) {
    throw UnimplementedError();
  }
}
