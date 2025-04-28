import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/project_details_use_case.dart';
import '../../../../../core/io/failure.dart';
import '../../../../../core/io/success.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  final DeleteTasksUseCase _deleteTaskUseCase;
  DeleteTaskCubit(this._deleteTaskUseCase) : super(DeleteTaskInitial());

  void deleteTask(int taskId) async {
    emit(DeleteTaskLoading());
    final res = await _deleteTaskUseCase.call(taskId);
    res.fold(
      (success) {
        emit(DeleteTaskSuccess(success: success));
      },
      (failure) {
        emit(DeleteTaskFailure(failure: failure));
      },
    );
  }
}
