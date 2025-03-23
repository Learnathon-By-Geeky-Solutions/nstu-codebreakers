import 'package:get_it/get_it.dart';
import 'package:task_hive/core/database_service/remote/supabase_init.dart';
import 'package:task_hive/core/database_service/remote/supabase_init_imp.dart';
import 'package:task_hive/features/onboarding/presentation/onboarding_cubit/onboarding_cubit.dart';

import '../../features/onboarding/data/data_source/local_data_source/onboarding_local_data_source.dart';
import '../../features/onboarding/data/data_source/local_data_source/onboarding_local_data_source_imp.dart';
import '../../features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source.dart';
import '../../features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source_imp.dart';
import '../../features/onboarding/data/repository_imp/onboarding_repo_imp.dart';
import '../../features/onboarding/domain/repository/onboarding_repository.dart';
import '../../features/onboarding/domain/use_case/onboarding_use_case.dart';
import '../base/cubit/base_cubit.dart';
import '../base/cubit/base_state.dart';
import '../database_service/local/shared_preference_service.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<BaseCubit>(() => BaseCubit(BaseState()));
  getIt.registerLazySingleton<SupabaseInit>(() => SupabaseInitImpl());
  getIt.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceService());

  // Register Cubits
  getIt.registerFactory(() => OnboardingCubit(getIt.call()));

  //Register UseCases
  getIt.registerLazySingleton<OnboardingUseCase>(
      () => OnboardingUseCase(getIt.call()));

  // Register Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepoImp(getIt.call(), getIt.call()));

  // Register DataSources
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImp());
  getIt.registerLazySingleton<OnboardingRemoteDataSource>(
      () => OnboardingRemoteDataSourceImp());
}
