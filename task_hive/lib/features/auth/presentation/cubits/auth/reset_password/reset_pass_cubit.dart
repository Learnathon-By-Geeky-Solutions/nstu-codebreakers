import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'reset_pass_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPasswordUseCase)
      : super(ResetPasswordInitial());

  final ResetPasswordUseCase _resetPasswordUseCase;

  void resetPassword(String email, String otp, String pass) async {
    emit(ResetPasswordLoading());
    final res = await _resetPasswordUseCase.call({
      'email': email,
      'otp': otp,
      'password': pass,
    });

    res.fold(
      (l) {
        emit(ResetPasswordFailed(l));
      },
      (r) {
        emit(ResetPasswordSuccess(r));
      },
    );
  }
}
