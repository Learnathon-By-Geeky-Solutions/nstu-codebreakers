part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpSuccess extends SignUpState {
  final Success success;
  SignUpSuccess(this.success);
}

class SignUpFailed extends SignUpState {
  final Failure failure;
  SignUpFailed(this.failure);
}

class SignUpLoading extends SignUpState {}

class SignUpInitial extends SignUpState {}
