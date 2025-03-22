import '../../../../../core/database_service/local/shared_preference_service.dart';
import '../../../../../core/di/di.dart';
import 'onboarding_local_data_source.dart';

final class OnboardingLocalDataSourceImp implements OnboardingLocalDataSource {
  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await getIt<SharedPreferenceService>().getInstance();
    bool hasSeenOnboarding = prefs.getBool('onboardingCompleted') ?? false;
    return hasSeenOnboarding;
  }
}
