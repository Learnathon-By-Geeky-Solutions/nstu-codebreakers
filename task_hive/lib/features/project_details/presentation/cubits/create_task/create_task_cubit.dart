import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hive/features/project_details/domain/entity/task_entity.dart';

import '../../../../../core/io/failure.dart';
import '../../../../../core/io/success.dart';
import '../../../domain/use_case/project_details_use_case.dart';
import 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTaskUseCase _createTaskUseCase;
  CreateTaskCubit(this._createTaskUseCase) : super(CreateTaskInitialState());

  void createTask(TaskEntity task) async {
    emit(CreateTaskLoadingState());
    final res = await _createTaskUseCase.call(task);
    res.fold(
      (l) {
        emit(CreateTaskSuccessState(success: l));
      },
      (r) {
        emit(CreateTaskErrorState(failure: r));
      },
    );
  }
}
