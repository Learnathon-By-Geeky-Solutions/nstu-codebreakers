
part of 'google_sign_in_cubit.dart';

class GoogleSignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleSignInSuccess extends GoogleSignInState {
  final Success success;
  GoogleSignInSuccess(this.success);
}

class GoogleSignInFailed extends GoogleSignInState {
  final Failure failure;
  GoogleSignInFailed(this.failure);
}

class GoogleSignInLoading extends GoogleSignInState {}

class GoogleSignInInitial extends GoogleSignInState {}