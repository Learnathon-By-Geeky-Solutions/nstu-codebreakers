import 'package:get_it/get_it.dart';
import 'package:task_hive/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:task_hive/features/auth/data/data_source/remote/auth_data_source_impl.dart';
import 'package:task_hive/features/auth/data/repository/auth_reposity_impl.dart';
import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';
import 'package:task_hive/features/auth/domain/use_case/auth_use_case.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/sign_in_cubit.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/sign_up/sign_up_cubit.dart';

import '../services/auth_service/auth_service.dart';
import '../services/auth_service/supabase_impl.dart';
import '../../features/onboarding/presentation/onboarding_cubit/onboarding_cubit.dart';
import '../../features/onboarding/data/data_source/local_data_source/onboarding_local_data_source.dart';
import '../../features/onboarding/data/data_source/local_data_source/onboarding_local_data_source_imp.dart';
import '../../features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source.dart';
import '../../features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source_imp.dart';
import '../../features/onboarding/data/repository_imp/onboarding_repo_imp.dart';
import '../../features/onboarding/domain/repository/onboarding_repository.dart';
import '../../features/onboarding/domain/use_case/onboarding_use_case.dart';
import '../base/cubit/base_cubit.dart';
import '../base/cubit/base_state.dart';
import '../services/local/shared_preference_services.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<BaseCubit>(() => BaseCubit(BaseState()));
  getIt.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceService());
  getIt.registerLazySingleton<AuthService>(() => SupabaseImpl());

  /// Register Cubits
  getIt.registerFactory(() => OnboardingCubit(getIt.call()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt.call()));

  ///Register UseCases
  getIt.registerLazySingleton<OnboardingUseCase>(
      () => OnboardingUseCase(getIt.call()));
  getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(getIt.call()));

  /// Register Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepoImp(getIt.call(), getIt.call()));
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthReposityImpl(getIt.call()));

  /// Register DataSources
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImp());
  getIt.registerLazySingleton<OnboardingRemoteDataSource>(
      () => OnboardingRemoteDataSourceImp());
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
}
