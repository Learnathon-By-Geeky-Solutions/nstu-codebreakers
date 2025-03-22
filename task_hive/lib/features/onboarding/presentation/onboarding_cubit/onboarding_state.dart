part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final bool isFirstTime, isSignedIn;
  const OnboardingLoaded(this.isFirstTime, this.isSignedIn);
  @override
  List<Object> get props => [isFirstTime, isSignedIn];
}

final class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object> get props => [message];
}
