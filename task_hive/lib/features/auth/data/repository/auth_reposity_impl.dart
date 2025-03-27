import 'package:dartz/dartz.dart';

import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/auth/data/data_source/remote/auth_data_source.dart';

import 'package:task_hive/features/auth/domain/entity/user_info.dart';

import '../../domain/repository/auth_repository.dart';

class AuthReposityImpl implements AuthRepository {
  AuthDataSource _authDataSource;

  AuthReposityImpl(this._authDataSource);

  @override
  Future<Either<UserInfo, Failure>> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Success, Failure>> signIn(Map<String, dynamic> input) async {
    try {
      final res = await _authDataSource.signIn(input);

      return Left(Success('Sign In Successful'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Success, Failure>> signUp(Map<String, dynamic> input) async {
    try {
      await _authDataSource.signUp(input);
      return Left(Success('Sign Up Success'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<UserInfo, Failure>> verifyOtp() {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
