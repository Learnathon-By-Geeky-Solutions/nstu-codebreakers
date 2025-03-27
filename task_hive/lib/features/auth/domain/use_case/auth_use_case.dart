import 'package:dartz/dartz.dart';
import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../../../../core/base/use_case/base_use_case.dart';

class SignUpUseCase
    extends BaseUseCase<Map<String, dynamic>, Success, Failure> {
  final AuthRepository _authRepository;
  SignUpUseCase(this._authRepository);

  @override
  Future<Either<Success, Failure>> call(Map<String, dynamic> input) async {
    return await _authRepository.signUp(input);
  }
}

class SignInUseCase
    extends BaseUseCase<Map<String, dynamic>, Success, Failure> {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  @override
  Future<Either<Success, Failure>> call(Map<String, dynamic> input) async {
    return await _authRepository.signIn(input);
  }
}
