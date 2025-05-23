import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hive/features/onboarding/domain/use_case/onboarding_use_case.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingUseCase onboardingUseCase;

  OnboardingCubit(this.onboardingUseCase) : super(OnboardingInitial());

  void checkOnboardingStatus() async {
    emit(OnboardingLoading());
    await Future.delayed(const Duration(seconds: 1));

    final onboardStatus = await onboardingUseCase.isOnboardingCompleted();

    bool? onboardComplete, signedIn;
    onboardStatus.fold((l) {
      onboardComplete = l;
    }, (r) {
      emit(OnboardingError(r));
    });

    final signedInStatus = await onboardingUseCase.checkSignedInStatus();

    signedInStatus.fold((l) {
      signedIn = l;
    }, (r) {
      emit(OnboardingError(r));
    });
    if (onboardComplete != null && signedIn != null) {
      emit(OnboardingLoaded(onboardComplete!, signedIn!));
    } else {
      emit(const OnboardingError("Error: Onboarding status not found"));
    }
  }

  void setOnboardingCompleted() async {
    final response = await onboardingUseCase.setOnboardingCompleted();
    response.fold((_) {}, (r) {
      emit(OnboardingError(r));
    });
  }
}
