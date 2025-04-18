part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final Success success;
  SignInSuccess(this.success);
}

class SignInFailed extends SignInState {
  final Failure failure;
  SignInFailed(this.failure);
}

class SignInLoading extends SignInState {}

class SignInInitial extends SignInState {}
