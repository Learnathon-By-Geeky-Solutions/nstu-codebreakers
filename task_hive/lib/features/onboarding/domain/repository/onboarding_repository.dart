abstract class OnboardingRepository {
  Future<bool> isOnboardingCompleted();
  Future<bool> checkSignedInStatus();
}
