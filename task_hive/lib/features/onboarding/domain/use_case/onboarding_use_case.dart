import '../repository/onboarding_repository.dart';

class OnboardingUseCase {
  final OnboardingRepository _onboardingRepository;

  OnboardingUseCase(this._onboardingRepository);

  Future<bool> isOnboardingCompleted() async {
    return await _onboardingRepository.isOnboardingCompleted();
  }

  Future<bool> checkSignedInStatus() async {
    return await _onboardingRepository.checkSignedInStatus();
  }
}
