import 'package:equatable/equatable.dart';

import '../../../../../core/io/failure.dart';
import '../../../domain/entity/task_entity.dart';

class FetchTasksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTasksSuccessState extends FetchTasksState {
  final List<TaskEntity> tasks;
  FetchTasksSuccessState({required this.tasks});
  @override
  List<Object?> get props => [tasks];
}

class FetchTasksLoadingState extends FetchTasksState {}

class FetchTasksInitial extends FetchTasksState {}

class FetchTasksErrorState extends FetchTasksState {
  final Failure failure;
  FetchTasksErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
