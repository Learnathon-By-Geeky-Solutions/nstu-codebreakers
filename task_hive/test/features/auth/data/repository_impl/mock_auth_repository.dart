import 'package:mocktail/mocktail.dart';
import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/core/io/success.dart';
import 'package:task_hive/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future<Either<Failure, Success>> signIn(UserEntity userEntity) async {
    return Right(Success('Sign in successful'));
  }

  @override
  Future<Either<Failure, Success>> signUp(UserEntity userEntity) async {
    return Right(Success('Sign up successful'));
  }

  @override
  Future<Either<Failure, Success>> googleSignIn() async {
    return Right(Success('Google sign in successful'));
  }
}
