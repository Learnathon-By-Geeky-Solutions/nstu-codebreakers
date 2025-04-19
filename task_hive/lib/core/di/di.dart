import 'package:get_it/get_it.dart';
import 'package:task_hive/features/auth/data/data_source/local/auth_local.dart';
import 'package:task_hive/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:task_hive/features/auth/data/data_source/remote/auth_remote_impl.dart';

import 'package:task_hive/features/auth/domain/repository/auth_repository.dart';
import 'package:task_hive/features/auth/domain/use_case/auth_use_case.dart';
import '''
package:task_hive/features/auth/presentation/cubits/auth/forget_password/forget_pass_cubit.dart''';
import '''
package:task_hive/features/auth/presentation/cubits/auth/sign_up/sign_up_cubit.dart''';
import '''
package:task_hive/features/home/data/data_source/local/home_local.dart''';
import '''
package:task_hive/features/home/data/data_source/remote/home_remote.dart''';
import '''
package:task_hive/features/home/data/data_source/remote/home_remote_imp.dart''';
import 'package:task_hive/features/home/presentation/cubits/create_project/create_project_cubit.dart';

import '../../features/auth/data/data_source/local/auth_local_imp.dart';
import '../../features/auth/data/repository_impl/auth_reposity_impl.dart';
import '../../features/auth/presentation/cubits/auth/sign_in/sign_in_cubit.dart';
import '../../features/home/data/data_source/local/home_local_impl.dart';
import '../../features/home/data/repository_imp/home_repo_imp.dart';
import '../../features/home/domain/repository/home_repository.dart';
import '../../features/home/domain/use_cases/home_use_cases.dart';
import '../../features/home/presentation/cubits/fetch_projects/fetch_projects_cubit.dart';
import '../../features/home/presentation/cubits/fetch_user/fetch_user_cubit.dart';
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
  getIt.registerFactory<SignInCubit>(() => SignInCubit(getIt.call()));
  getIt.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(getIt.call()));
  getIt.registerCachedFactory<FetchProjectsCubit>(
      () => FetchProjectsCubit(getIt.call()));
  getIt.registerCachedFactory<FetchUserCubit>(
      () => FetchUserCubit(getIt.call()));
  getIt.registerCachedFactory<CreateProjectCubit>(
      () => CreateProjectCubit(getIt.call()));

  ///Register UseCases
  getIt.registerLazySingleton<OnboardingUseCase>(
      () => OnboardingUseCase(getIt.call()));
  getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(getIt.call()));
  getIt.registerLazySingleton<SignInUseCase>(() => SignInUseCase(getIt.call()));
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(getIt.call()));
  getIt.registerLazySingleton<FetchProjectsUseCase>(
      () => FetchProjectsUseCase(getIt.call()));
  getIt.registerLazySingleton<FetchUserUseCase>(
      () => FetchUserUseCase(getIt.call()));
  getIt.registerLazySingleton<CreateProjectUseCase>(
      () => CreateProjectUseCase(getIt.call()));

  /// Register Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepoImp(getIt.call(), getIt.call()));
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthReposityImpl(getIt.call(), getIt.call()));
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt.call(), getIt.call()));

  /// Register DataSources
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImp());
  getIt.registerLazySingleton<OnboardingRemoteDataSource>(
      () => OnboardingRemoteDataSourceImp());
  getIt.registerLazySingleton<AuthRemote>(() => AuthRemoteImpl());
  getIt.registerLazySingleton<AuthLocal>(() => AuthLocalImpl());
  getIt.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());
  getIt.registerLazySingleton<HomeLocal>(() => HomeLocalImpl());
}
