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
      // Only upload image if a new image is provided
      if (profileInfo.url != null && profileInfo.url!.isNotEmpty) {
        profileInfo.url =
            await _profileDataSource.uploadProfileImage(profileInfo.url!);
      }

      // Prepare update data
      final updateData = profileInfo.toJson();
      if (updateData.isEmpty) {
        return Left('No data to update');
      }

      // Update profile and get the result
      final res = await _profileDataSource.updateProfileInfo(updateData);
      final updatedProfileInfo = ProfileModel.fromJson(res).toEntity();
      print('dbg updated profile info: ${updatedProfileInfo.toJson()}');
      return Right(updatedProfileInfo);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
