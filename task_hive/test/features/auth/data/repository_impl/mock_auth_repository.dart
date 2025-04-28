import 'package:mocktail/mocktail.dart';
import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future<Either<Success, Failure>> signIn(UserEntity userEntity) async {
    return Left(Success('Sign in successful'));
  }

  @override
  Future<Either<Success, Failure>> signUp(UserEntity userEntity) async {
    return Left(Success('Sign up successful'));
  }

  @override
  Future<Either<Success, Failure>> googleSignIn() async {
    return Left(Success('Google sign in successful'));
  }
}
