import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/io/failure.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/use_case/project_details_use_case.dart';

part 'fetch_task_state.dart';

class FetchTaskCubit extends Cubit<FetchTaskState> {
  final FetchTaskUseCase _fetchTaskUseCase;

  FetchTaskCubit(this._fetchTaskUseCase) : super(FetchTaskInitialState());

  Future<void> fetchTask(int taskId) async {
    emit(FetchTaskLoadingState());
    try {
      final result = await _fetchTaskUseCase.call(taskId);
      result.fold(
        (failure) => emit(FetchTaskErrorState(failure: failure)),
        (task) => emit(FetchTaskSuccessState(task: task)),
      );
    } catch (e) {
      emit(FetchTaskErrorState(failure: Failure('Failed to fetch task')));
    }
  }
}
