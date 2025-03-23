import 'package:dartz/dartz.dart';

abstract class OnboardingRemoteDataSource {
  /// Checks if user is currently signed in
  ///
  /// Returns Either containing:
  /// - Right(true) if user is signed in
  /// - Left(errorMessage) if user is not signed in or error occurred
  Future<Either<bool, String>> checkSignedInStatus();
}
