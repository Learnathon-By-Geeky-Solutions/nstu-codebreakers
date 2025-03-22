import 'package:task_hive/features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source.dart';

import '../../domain/repository/onboarding_repository.dart';
import '../data_source/local_data_source/onboarding_local_data_source.dart';

class OnboardingRepoImp implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;
  final OnboardingRemoteDataSource remoteDataSource;

  OnboardingRepoImp(
    this.localDataSource,
    this.remoteDataSource,
  );

  @override
  Future<bool> checkSignedInStatus() {
    return remoteDataSource.checkSignedInStatus();
  }

  @override
  Future<bool> isOnboardingCompleted() {
    return localDataSource.isOnboardingCompleted();
  }
}
