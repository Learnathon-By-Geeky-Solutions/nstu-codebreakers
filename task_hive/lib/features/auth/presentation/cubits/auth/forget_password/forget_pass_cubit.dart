import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'forget_pass_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgetPasswordUseCase)
      : super(ForgetPasswordInitial());

  final ForgetPasswordUseCase _forgetPasswordUseCase;

  void forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final res = await _forgetPasswordUseCase.call(email);

    res.fold((l) {
      emit(ForgetPasswordFailed(l));
    }, (r) {
      emit(ForgetPasswordSuccess(r));
    });
  }
}
