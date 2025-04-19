import 'package:equatable/equatable.dart';

import '../../../../../core/io/failure.dart';
import '../../../../../core/io/success.dart';

class CreateProjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateProjectInitial extends CreateProjectState {}

class CreateProjectLoading extends CreateProjectState {}

class CreateProjectSuccess extends CreateProjectState {
  final Success success;
  CreateProjectSuccess({required this.success});
  @override
  List<Object?> get props => [success];
}

class CreateProjectFailure extends CreateProjectState {
  final Failure failure;
  CreateProjectFailure({required this.failure});
  @override
  List<Object?> get props => [failure];
}
