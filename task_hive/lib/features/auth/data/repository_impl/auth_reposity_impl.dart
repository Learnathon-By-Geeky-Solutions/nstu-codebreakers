import 'package:dartz/dartz.dart';
import 'package:task_hive/features/auth/data/data_source/local/auth_local.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../data_source/remote/auth_remote.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';

class AuthReposityImpl implements AuthRepository {
  final AuthRemote _authRemoteDataSource;
  final AuthLocal _authLocalDataSource;

  AuthReposityImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Success, Failure>> forgetPassword(String email) async {
    try {
      await _authRemoteDataSource.forgetPassword(email);
      return Left(Success('OTP sent to your email'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Success, Failure>> signIn(UserEntity userInfo) async {
    try {
      final response = await _authRemoteDataSource.signIn(userInfo);
      if (response.user == null) {
        return Right(Failure('User not found'));
      }
      final userData = await _authRemoteDataSource.getUser(userInfo.email);
      await _authLocalDataSource.saveUser(userData);
      return Left(Success('User Successfully signed in'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Success, Failure>> signUp(UserEntity userInfo) async {
    try {
      await _authRemoteDataSource.signUp(userInfo);

      await _authRemoteDataSource.addUser(userInfo);

      return Left(Success('Verification email is sent.'));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<UserEntity, Failure>> verifyOtp() async {
    return Right(Failure('verifyOtp() not yet implemented'));
  }
}
