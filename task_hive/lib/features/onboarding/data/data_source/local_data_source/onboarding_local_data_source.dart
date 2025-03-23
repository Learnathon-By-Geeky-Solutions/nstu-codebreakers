import 'package:dartz/dartz.dart';

abstract class OnboardingLocalDataSource {
  /// Checks if user completed onboarding
  ///
  /// Returns Either containing:
  /// - Right is for error
  /// - Left is for success
  Future<Either<bool, String>> isOnboardingCompleted();
  Future<Either<void, String>> setOnboardingCompleted();
}
