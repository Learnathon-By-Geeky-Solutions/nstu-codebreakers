part of 'forget_pass_cubit.dart';

class ForgetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final Success success;
  ForgetPasswordSuccess(this.success);
}

class ForgetPasswordFailed extends ForgetPasswordState {
  final Failure failure;
  ForgetPasswordFailed(this.failure);
}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}
