import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/use_case/auth_use_case.dart';
part 'google_sign_in_state.dart';


class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit(this._googleSignInUseCase) : super(GoogleSignInInitial());

  final GoogleSignInUseCase _googleSignInUseCase;

  void signInWithGoogle() async {
    emit(GoogleSignInLoading());
    final res = await _googleSignInUseCase.call(null);

    res.fold(
      (l) => emit(GoogleSignInSuccess(l)),
      (r) => emit(GoogleSignInFailed(r)),
    );
  }
}



