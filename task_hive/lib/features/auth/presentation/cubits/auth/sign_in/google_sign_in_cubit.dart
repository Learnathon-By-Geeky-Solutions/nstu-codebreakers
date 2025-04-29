import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/use_case/auth_use_case.dart';
part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  final GoogleSignInUseCase _googleSignInUseCase;

  GoogleSignInCubit(this._googleSignInUseCase) : super(GoogleSignInInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    try {
      final result = await _googleSignInUseCase.call(null);
      result.fold(
        (failure) => emit(GoogleSignInFailed(failure)),
        (success) => emit(GoogleSignInSuccess(success)),
      );
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(GoogleSignInFailed(Failure(message)));
    }
  }
}
