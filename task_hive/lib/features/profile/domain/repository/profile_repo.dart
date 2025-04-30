import 'package:dartz/dartz.dart';

import '../entity/profile_info.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileInfo>> getProfileInfo(int userId);
  Future<Either<String, ProfileInfo>> updateProfileInfo(
      ProfileInfo profileInfo);
}
