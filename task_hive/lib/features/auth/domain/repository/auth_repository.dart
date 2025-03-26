import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entity/user_info.dart';

abstract class AuthRepository {
  Future<Either<Success,Failure>> signUp(Map<String,dynamic> input);
  Future<Either<UserInfo,Failure>> signIn();
  Future<Either<UserInfo,Failure>> forgetPassword();
  Future<Either<UserInfo,Failure>> verifyOtp();
}