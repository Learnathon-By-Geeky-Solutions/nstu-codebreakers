import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/home_use_cases.dart';
import 'fetch_projects_state.dart';

class FetchProjectsCubit extends Cubit<FetchProjectsState> {
  final FetchProjectsUseCase _fetchProjectsUseCase;
  FetchProjectsCubit(this._fetchProjectsUseCase)
      : super(FetchProjectsInitial());

  void fetchProjects({required int userId}) async {
    emit(FetchProjectsLoading());
    try {
      final result = await _fetchProjectsUseCase.call(userId);
      result.fold((l) {
        emit(FetchProjectsSuccess(l));
      }, (r) {
        emit(FetchProjectsFailed(r));
      });
    } catch (e) {
      emit(FetchProjectsFailed(e.toString()));
    }
  }
}
