import 'package:dartz/dartz.dart';
import 'package:task_hive/features/home/domain/entities/home_user_entity.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entities/project_entity.dart';

abstract class HomeRepository {
  Future<Either<HomePageUserEntity, String>> fetchUser();
  Future<Either<List<ProjectEntity?>, String>> fetchProject(int userId);
  Future<Either<Success, Failure>> createProject(ProjectEntity project);
  Future<void> deleteProject(String id);
  Future<void> updateProject(Map<String, dynamic> project);
}
