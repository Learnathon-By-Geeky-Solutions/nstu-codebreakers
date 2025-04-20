import 'package:equatable/equatable.dart';

import '../../../../../core/io/failure.dart';
import '../../../../../core/io/success.dart';

class CreateTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTaskInitialState extends CreateTaskState {}

class CreateTaskLoadingState extends CreateTaskState {}

class CreateTaskSuccessState extends CreateTaskState {
  final Success success;
  CreateTaskSuccessState({required this.success});

  @override
  List<Object?> get props => [success];
}

class CreateTaskErrorState extends CreateTaskState {
  final Failure failure;
  CreateTaskErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
