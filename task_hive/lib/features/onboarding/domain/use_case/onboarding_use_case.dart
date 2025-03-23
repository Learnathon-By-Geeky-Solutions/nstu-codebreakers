import 'package:dartz/dartz.dart';

import '../repository/onboarding_repository.dart';

class OnboardingUseCase {
  final OnboardingRepository _onboardingRepository;

  OnboardingUseCase(this._onboardingRepository);

  Future<Either<bool, String>> isOnboardingCompleted() {
    return _onboardingRepository.isOnboardingCompleted();
  }

  Future<Either<bool, String>> checkSignedInStatus() {
    return _onboardingRepository.checkSignedInStatus();
  }

  Future<Either<void, String>> setOnboardingCompleted() {
    return _onboardingRepository.setOnboardingCompleted();
  }
}
