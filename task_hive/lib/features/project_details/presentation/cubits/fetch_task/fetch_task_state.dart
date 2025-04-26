part of 'fetch_task_cubit.dart';

class FetchTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTaskInitialState extends FetchTaskState {}

class FetchTaskLoadingState extends FetchTaskState {}

class FetchTaskSuccessState extends FetchTaskState {
  final TaskEntity task;
  FetchTaskSuccessState({required this.task});
  @override
  List<Object?> get props => [task];
}

class FetchTaskErrorState extends FetchTaskState {
  final Failure failure;
  FetchTaskErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

///title, description, subtasks, start date, due date, label, 
///assignees, attachments