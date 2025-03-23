import 'package:dartz/dartz.dart';

abstract class OnboardingRepository {
  Future<Either<bool, String>> isOnboardingCompleted();
  Future<Either<bool, String>> checkSignedInStatus();
  Future<Either<void, String>> setOnboardingCompleted();
}
