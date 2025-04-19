import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hive/core/io/failure.dart';
import 'package:task_hive/features/home/domain/entities/project_entity.dart';
import 'package:task_hive/features/home/domain/use_cases/home_use_cases.dart';

import 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  final CreateProjectUseCase _createProjectUseCase;
  CreateProjectCubit(this._createProjectUseCase)
      : super(CreateProjectInitial());
  void createProject(ProjectEntity project) {
    emit(CreateProjectLoading());
    try {
      final res = _createProjectUseCase.call(project);
      res.then((value) {
        value.fold((l) {
          emit(CreateProjectSuccess(success: l));
        }, (r) {
          emit(CreateProjectFailure(failure: r));
        });
      });
    } catch (e) {
      emit(CreateProjectFailure(failure: Failure(e.toString())));
    }
  }
}
