import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/entity/user_entity.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpUseCase) : super(SignUpInitial());

  final SignUpUseCase _signUpUseCase;

  void signUp(UserEntity userEntity) async {
    emit(SignUpLoading());
    final res = await _signUpUseCase.call(userEntity);

    res.fold((l) {
      emit(SignUpFailed(l));
    }, (r) {
      emit(SignUpSuccess(r));
    });
  }
}
