import 'package:dartz/dartz.dart';

abstract class OnboardingLocalDataSource {
  Future<Either<bool, String>> isOnboardingCompleted();
  Future<Either<void, String>> setOnboardingCompleted();
}
