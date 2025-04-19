import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entities/home_user_entity.dart';
import '../../../../core/base/use_case/base_use_case.dart';
import '../../../../core/io/no_input.dart';
import '../entities/project_entity.dart';
import '../repository/home_repository.dart';

class FetchProjectsUseCase
    extends BaseUseCase<int, List<ProjectEntity?>, String> {
  final HomeRepository _projectRepository;
  FetchProjectsUseCase(this._projectRepository);

  @override
  Future<Either<List<ProjectEntity?>, String>> call(int input) async {
    return await _projectRepository.fetchProject(input);
  }
}

class FetchUserUseCase
    extends BaseUseCase<NoInput, HomePageUserEntity, String> {
  final HomeRepository _projectRepository;
  FetchUserUseCase(this._projectRepository);

  @override
  Future<Either<HomePageUserEntity, String>> call(NoInput input) async {
    return await _projectRepository.fetchUser();
  }
}

class CreateProjectUseCase
    extends BaseUseCase<ProjectEntity, Success, Failure> {
  final HomeRepository _projectRepository;
  CreateProjectUseCase(this._projectRepository);

  @override
  Future<Either<Success, Failure>> call(ProjectEntity input) async {
    return await _projectRepository.createProject(input);
  }
}
