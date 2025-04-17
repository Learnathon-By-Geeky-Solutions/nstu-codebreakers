part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final UserEntity userData;
  SignInSuccess(this.userData);
}

class SignInFailed extends SignInState {
  final Failure failure;
  SignInFailed(this.failure);
}

class SignInLoading extends SignInState {}

class SignInInitial extends SignInState {}
