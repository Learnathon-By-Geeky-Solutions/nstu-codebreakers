import 'package:equatable/equatable.dart';
import '../../../domain/entities/project_entity.dart';

abstract class FetchProjectsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProjectsSuccess extends FetchProjectsState {
  final List<ProjectEntity?> projects;
  FetchProjectsSuccess(this.projects);
  @override
  List<Object?> get props => [projects];
}

class FetchProjectsFailure extends FetchProjectsState {
  final dynamic failure;
  FetchProjectsFailure(this.failure);
  @override
  List<Object?> get props => [failure];
}

class FetchProjectsLoading extends FetchProjectsState {}

class FetchProjectsInitial extends FetchProjectsState {}
