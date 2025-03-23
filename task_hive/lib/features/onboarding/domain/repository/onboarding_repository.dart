import 'package:dartz/dartz.dart';

abstract class OnboardingRepository {
  ///Left is for success
  ///Right is for error
  Future<Either<bool, String>> isOnboardingCompleted();
  Future<Either<bool, String>> checkSignedInStatus();
  Future<Either<void, String>> setOnboardingCompleted();
}
