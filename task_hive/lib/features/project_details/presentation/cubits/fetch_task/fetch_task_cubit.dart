import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/io/failure.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/use_case/project_details_use_case.dart';

part 'fetch_task_state.dart';

class FetchTaskCubit extends Cubit<FetchTaskState> {
  final FetchTaskUseCase fetchTaskUseCase;
  FetchTaskCubit(this.fetchTaskUseCase) : super(FetchTaskInitialState());

  void fetchTask(int taskId) async {
    emit(FetchTaskLoadingState());
    try {
      final res = await fetchTaskUseCase.call(taskId);
      res.fold((l) {
        emit(FetchTaskSuccessState(task: l));
      }, (r) {
        emit(FetchTaskErrorState(failure: r));
      });
    } catch (e) {
      emit(FetchTaskErrorState(failure: Failure('Failed to fetch task')));
    }
  }
}
