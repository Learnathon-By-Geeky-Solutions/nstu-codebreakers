import 'package:dartz/dartz.dart';
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
  Future<Either<bool, String>> checkSignedInStatus() async {
    return await remoteDataSource.checkSignedInStatus();
  }

  @override
  Future<Either<bool, String>> isOnboardingCompleted() async {
    return await localDataSource.isOnboardingCompleted();
  }

  @override
  Future<Either<void, String>> setOnboardingCompleted() async {
    return await localDataSource.setOnboardingCompleted();
  }
}
