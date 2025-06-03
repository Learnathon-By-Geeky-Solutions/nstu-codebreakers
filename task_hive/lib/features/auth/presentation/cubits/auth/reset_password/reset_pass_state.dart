part of 'reset_pass_cubit.dart';

class ResetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccess extends ResetPasswordState {
  final Success success;
  ResetPasswordSuccess(this.success);

  @override
  List<Object?> get props => [success];
}

class ResetPasswordFailed extends ResetPasswordState {
  final Failure failure;
  ResetPasswordFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}
