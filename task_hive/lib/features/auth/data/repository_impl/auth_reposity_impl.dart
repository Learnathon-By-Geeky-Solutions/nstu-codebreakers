import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
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
  Future<Either<Failure, Success>> forgetPassword(String email) async {
    try {
      await _authRemoteDataSource.forgetPassword(email);
      return Right(Success('OTP sent to your email'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> signIn(UserEntity userInfo) async {
    try {
      final response = await _authRemoteDataSource.signIn(userInfo);
      if (response.user == null) {
        return Left(Failure('User not found'));
      }
      final userData = await _authRemoteDataSource.getUser(userInfo.email);
      await _authLocalDataSource.saveUser(userData);
      return Right(Success('User Successfully signed in'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> signUp(UserEntity userInfo) async {
    try {
      await _authRemoteDataSource.signUp(userInfo);
      await _authRemoteDataSource.addUser(userInfo);
      return Right(Success('Verification email is sent.'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp() async {
    return Left(Failure('verifyOtp() not yet implemented'));
  }

  @override
  Future<Either<Failure, Success>> signInWithGoogle() async {
    try {
      final response = await _authRemoteDataSource.signInWithGoogle();
      if (response.user == null) {
        return Left(Failure('User not found'));
      }
      await _authRemoteDataSource.addUser(
        UserEntity(
          id: int.tryParse(response.user!.id.toString()) ?? 0,
          email: response.user!.email ?? '',
          name: response.user!.userMetadata?['full_name']?.toString() ??
              'Unknown',
          profilePictureUrl:
              response.user!.userMetadata?['picture']?.toString() ?? '',
        ),
      );
      final userData =
          await _authRemoteDataSource.getUser(response.user!.email ?? '');
      await _authLocalDataSource.saveUser(userData);
      return Right(Success('User successfully signed in with Google'));
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      return Left(Failure(e.toString()));
    }
  }
}
