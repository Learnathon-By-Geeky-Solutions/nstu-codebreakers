import 'package:dartz/dartz.dart';
import 'package:task_hive/core/base/use_case/base_use_case.dart';
import 'package:task_hive/features/profile/domain/repository/profile_repo.dart';

import '../entity/profile_info.dart';

class ProfileFetchUseCase extends BaseUseCase<int, String, ProfileInfo> {
  final ProfileRepo _profileRepo;
  ProfileFetchUseCase(this._profileRepo);
  @override
  Future<Either<String, ProfileInfo>> call(int input) async {
    return await _profileRepo.getProfileInfo(input);
  }
}

class UpdateProfileUseCase
    extends BaseUseCase<ProfileInfo, String, ProfileInfo> {
  final ProfileRepo _profileRepo;
  UpdateProfileUseCase(this._profileRepo);
  @override
  Future<Either<String, ProfileInfo>> call(ProfileInfo input) async {
    return await _profileRepo.updateProfileInfo(input);
  }
}
