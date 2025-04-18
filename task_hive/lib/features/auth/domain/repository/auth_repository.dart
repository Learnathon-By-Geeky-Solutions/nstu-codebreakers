import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Success, Failure>> signUp(UserEntity userInfo);
  Future<Either<Success, Failure>> signIn(UserEntity userInfo);
  Future<Either<Success, Failure>> forgetPassword(String email);
  Future<Either<UserEntity, Failure>> verifyOtp();
}
