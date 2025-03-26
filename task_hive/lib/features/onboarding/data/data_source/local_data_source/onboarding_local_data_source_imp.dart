import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/services/local/shared_preference_services.dart';
import '../../../../../core/di/di.dart';
import 'onboarding_local_data_source.dart';

final class OnboardingLocalDataSourceImp implements OnboardingLocalDataSource {
  @override
  Future<Either<bool, String>> isOnboardingCompleted() async {
    try {
      final prefs = await getIt<SharedPreferenceService>().getInstance();
      bool hasSeenOnboarding = prefs.getBool('onboardingCompleted') ?? false;
      return Left(hasSeenOnboarding);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<void, String>> setOnboardingCompleted() async {
    try {
      final prefs = await getIt<SharedPreferenceService>().getInstance();
      await prefs.setBool('onboardingCompleted', true);
      return const Left(null);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
