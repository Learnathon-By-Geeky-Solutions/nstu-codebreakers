import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hive/core/io/no_input.dart';

import '../../../domain/use_cases/home_use_cases.dart';
import 'fetch_user_state.dart';

class FetchUserCubit extends Cubit<FetchUserState> {
  final FetchUserUseCase _fetchUserUseCase;
  FetchUserCubit(this._fetchUserUseCase) : super(FetchUserInitial());

  void fetchUser() async {
    emit(FetchUserLoading());
    try {
      final res = await _fetchUserUseCase.call(NoInput());
      res.fold((l) {
        emit(FetchUserSuccess(l));
      }, (r) {
        emit(FetchUserFailed(r));
      });
    } catch (e) {
      emit(FetchUserFailed(e.toString()));
    }
  }
}
