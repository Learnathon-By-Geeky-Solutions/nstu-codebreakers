import 'package:dartz/dartz.dart';

import '../repository/onboarding_repository.dart';

class OnboardingUseCase {
  final OnboardingRepository _onboardingRepository;

  OnboardingUseCase(this._onboardingRepository);

  Future<Either<bool, String>> isOnboardingCompleted() async {
    return await _onboardingRepository.isOnboardingCompleted();
  }

  Future<Either<bool, String>> checkSignedInStatus() async {
    return await _onboardingRepository.checkSignedInStatus();
  }

  Future<Either<void, String>> setOnboardingCompleted() async {
    return await _onboardingRepository.setOnboardingCompleted();
  }
}
