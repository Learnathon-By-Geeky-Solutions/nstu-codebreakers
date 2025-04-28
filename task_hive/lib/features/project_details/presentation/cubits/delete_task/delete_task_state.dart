part of 'detele_task_cubit.dart';

class DeleteTaskState extends Equatable {
  const DeleteTaskState();

  @override
  List<Object?> get props => [];
}

class DeleteTaskInitial extends DeleteTaskState {}

class DeleteTaskLoading extends DeleteTaskState {}

class DeleteTaskSuccess extends DeleteTaskState {
  final Success success;

  const DeleteTaskSuccess({required this.success});

  @override
  List<Object?> get props => [success];
}

class DeleteTaskFailure extends DeleteTaskState {
  final Failure failure;

  const DeleteTaskFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
