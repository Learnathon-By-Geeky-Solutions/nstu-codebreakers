import 'package:dartz/dartz.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/home/data/data_source/local/home_local.dart';
import 'package:task_hive/features/home/domain/entities/home_user_entity.dart';

import '../data_source/remote/home_remote.dart';
import '../models/project_model.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemote _homeRemoteDataSource;
  final HomeLocal _homeLocalDataSource;
  HomeRepositoryImpl(this._homeRemoteDataSource, this._homeLocalDataSource);

  @override
  Future<void> deleteProject(String id) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<void> updateProject(Map<String, dynamic> project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<ProjectEntity?>>> fetchProject(int userId) async {
    try {
      final response = _homeRemoteDataSource.fetchProject(userId);
      final data = await response;
      final projectList =
          data.map((e) => ProjectModel.fromJson(e).toEntity()).toList();
      return Right(projectList);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, HomePageUserEntity>> fetchUser() async {
    try {
      final userId = await _homeLocalDataSource.getUserId();
      final response = await _homeRemoteDataSource.fetchUser(userId);
      final user = HomePageUserEntity.fromJson(response);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, Success>> createProject(ProjectEntity project) async {
    try {
      await _homeRemoteDataSource.addProject(project.toJson());

      return Right(Success('Project created successfully'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
