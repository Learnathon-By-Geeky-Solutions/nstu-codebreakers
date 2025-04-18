import 'package:dartz/dartz.dart';
import 'package:task_hive/features/home/domain/entities/home_user_entity.dart';

import '../entities/project_entity.dart';

abstract class HomeRepository {
  Future<Either<HomePageUserEntity, String>> fetchUser();
  Future<Either<List<ProjectEntity?>, String>> fetchProject(int userId);
  Future<void> addProject(Map<String, dynamic> project);
  Future<void> deleteProject(String id);
  Future<void> updateProject(Map<String, dynamic> project);
}
