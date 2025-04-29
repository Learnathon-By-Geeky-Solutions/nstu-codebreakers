import 'package:dartz/dartz.dart';
import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Success>> signUp(UserEntity userInfo);
  Future<Either<Failure, Success>> signIn(UserEntity userInfo);
  Future<Either<Failure, Success>> signInWithGoogle();
  Future<Either<Failure, Success>> forgetPassword(String email);
  Future<Either<Failure, UserEntity>> verifyOtp();
}
