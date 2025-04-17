import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../data_source/remote/auth_data_source.dart';
import '../model/sign_in_model.dart';
import '../../domain/entity/user_entity.dart';
import '../../../../core/logger/logger.dart';
import '../../domain/repository/auth_repository.dart';

class AuthReposityImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthReposityImpl(this._authDataSource);

  @override
  Future<Either<Success, Failure>> forgetPassword(String email) async {
    try {
      await _authDataSource.forgetPassword(email);
      return Left(Success('OTP sent to your email'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<UserEntity, Failure>> signIn(UserEntity userInfo) async {
    try {
      await _authDataSource.signIn(userInfo);

      final user = await _authDataSource.getUser();
      logger.e(user);

      return Left(SignInModel.fromJson(user).toEntity());
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Success, Failure>> signUp(UserEntity userInfo) async {
    try {
      await _authDataSource.signUp(userInfo);
      await _authDataSource.addUser(userInfo);
      return Left(Success('Verification email is sent.'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<UserEntity, Failure>> verifyOtp() {
    throw UnimplementedError();
  }
}
