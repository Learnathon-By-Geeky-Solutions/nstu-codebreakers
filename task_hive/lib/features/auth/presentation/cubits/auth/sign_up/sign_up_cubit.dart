import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpUseCase) : super(SignUpInitial());

  final SignUpUseCase _signUpUseCase;

  void signUp(Map<String, dynamic> input) async {
    emit(SignUpLoading());
    print('dbg before use case ecall');
    final res = await _signUpUseCase.call(input);
    print('dbg after use case ecall');

    res.fold((l) {
      emit(SignUpSuccess(l));
    }, (r) {
      emit(SignUpFailed(r));
    });
  }
}
