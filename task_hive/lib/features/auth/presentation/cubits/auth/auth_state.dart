part of 'sign_in_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class SignInSuccessState extends AuthState {
  final String successMessage;

  SignInSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class SignInFailedState extends AuthState {
  final String errorMessage;

  SignInFailedState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class SignUpInitialState extends AuthState {}

class SignUpSuccessState extends AuthState {
  final String successMessage;
  SignUpSuccessState({required this.successMessage});
  @override
  List<Object?> get props => [successMessage];
}

class SignUpFailedState extends AuthState {
  final String errorMessage;
  SignUpFailedState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class SentVerEmailSuccess extends AuthState {
  final String successMessage;
  SentVerEmailSuccess({required this.successMessage});
  @override
  List<Object?> get props => [successMessage];
}

class SentVerEmailFailed extends AuthState {
  final String failedMessage;
  SentVerEmailFailed({required this.failedMessage});
  @override
  List<Object?> get props => [failedMessage];
}

class LoadingState extends AuthState {}
