import 'package:dartz/dartz.dart';
import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../../../../core/base/use_case/base_use_case.dart';
import '../entity/user_entity.dart';

class SignUpUseCase extends BaseUseCase<UserEntity, Success, Failure> {
  final AuthRepository _authRepository;
  SignUpUseCase(this._authRepository);

  @override
  Future<Either<Success, Failure>> call(UserEntity input) async {
    return await _authRepository.signUp(input);
  }
}

class SignInUseCase extends BaseUseCase<UserEntity, Success, Failure> {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  @override
  Future<Either<Success, Failure>> call(UserEntity input) async {
    return await _authRepository.signIn(input);
  }
}

class ForgetPasswordUseCase extends BaseUseCase<String, Success, Failure> {
  final AuthRepository _authRepository;
  ForgetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Success, Failure>> call(String input) async {
    return await _authRepository.forgetPassword(input);
  }
}
