import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/home_use_cases.dart';
import '../../../../../core/io/failure.dart';
import 'fetch_projects_state.dart';

class FetchProjectsCubit extends Cubit<FetchProjectsState> {
  final FetchProjectsUseCase _fetchProjectsUseCase;
  FetchProjectsCubit(this._fetchProjectsUseCase)
      : super(FetchProjectsInitial());

  Future<void> fetchProjects(int userId) async {
    emit(FetchProjectsLoading());
    try {
      final result = await _fetchProjectsUseCase.call(userId);
      result.fold(
        (failure) => emit(FetchProjectsFailure(
            failure is Failure ? failure : Failure(failure.toString()))),
        (projects) => emit(FetchProjectsSuccess(projects)),
      );
    } catch (e) {
      emit(FetchProjectsFailure(Failure('Failed to fetch projects')));
    }
  }
}
