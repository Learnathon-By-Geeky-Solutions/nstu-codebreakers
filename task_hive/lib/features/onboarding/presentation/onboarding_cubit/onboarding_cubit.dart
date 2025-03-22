import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hive/features/onboarding/domain/use_case/onboarding_use_case.dart';

import '../../../../core/di/di.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void checkOnboardingStatus() async {
    print('dbg checkOnboardingStatus');
    emit(OnboardingLoading());
    Future.delayed(const Duration(seconds: 1));

    final isFirstTime =
        await getIt<OnboardingUseCase>().isOnboardingCompleted();
    print('dbg isFirstTime: $isFirstTime');

    final isSignedIn = await getIt<OnboardingUseCase>().checkSignedInStatus();
    print('dbg isSignedIn: $isSignedIn');
    emit(OnboardingLoaded(isFirstTime, isSignedIn));
  }
}
