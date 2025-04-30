import 'package:dartz/dartz.dart';
import 'package:task_hive/features/profile/data/data_source/profile_data_source.dart';
import 'package:task_hive/features/profile/data/model/profile_model.dart';
import 'package:task_hive/features/profile/domain/entity/profile_info.dart';

import '../../domain/repository/profile_repo.dart';

class ProfileRepoImp extends ProfileRepo {
  final ProfileDataSource _profileDataSource;
  ProfileRepoImp(this._profileDataSource);
  @override
  Future<Either<String, ProfileInfo>> getProfileInfo(int userId) async {
    try {
      final response = await _profileDataSource.getProfileInfo(userId);
      final profileInfo = ProfileModel.fromJson(response).toEntity();
      return Right(profileInfo);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ProfileInfo>> updateProfileInfo(
      ProfileInfo profileInfo) async {
    try {
      final res =
          await _profileDataSource.updateProfileInfo(profileInfo.toJson());
      final updatedProfileInfo = ProfileModel.fromJson(res).toEntity();
      return Right(updatedProfileInfo);
    } catch (e) {
      throw Exception('Error updating profile info: $e');
    }
  }
}
