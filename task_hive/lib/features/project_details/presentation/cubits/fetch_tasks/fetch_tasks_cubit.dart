import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/io/failure.dart';
import '../../../domain/use_case/project_details_use_case.dart';
import 'fetch_tasks_state.dart';

class FetchTasksCubit extends Cubit<FetchTasksState> {
  final FetchTasksUseCase fetchTaskUseCase;
  FetchTasksCubit(this.fetchTaskUseCase) : super(FetchTasksInitial());

  void fetchTasks(int porjectId) async {
    emit(FetchTasksLoadingState());
    try {
      final res = await fetchTaskUseCase.call(porjectId);
      res.fold((l) {
        emit(FetchTasksErrorState(failure: l));
      }, (r) {
        emit(FetchTasksSuccessState(tasks: r));
      });
    } catch (e) {
      emit(FetchTasksErrorState(failure: Failure('Failed to fetch tasks')));
    }
  }
}
