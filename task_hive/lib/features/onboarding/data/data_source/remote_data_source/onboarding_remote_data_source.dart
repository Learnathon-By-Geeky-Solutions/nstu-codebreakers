import 'package:dartz/dartz.dart';

abstract class OnboardingRemoteDataSource {
  Future<Either<bool, String>> checkSignedInStatus();
}
