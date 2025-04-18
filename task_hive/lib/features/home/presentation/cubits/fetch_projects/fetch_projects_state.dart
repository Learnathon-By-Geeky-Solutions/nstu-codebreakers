import 'package:equatable/equatable.dart';

import '../../../domain/entities/project_entity.dart';

class FetchProjectsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProjectsSuccess extends FetchProjectsState {
  final List<ProjectEntity?> projects;
  FetchProjectsSuccess(this.projects);
  @override
  List<Object?> get props => [projects];
}

class FetchProjectsFailed extends FetchProjectsState {
  final String error;
  FetchProjectsFailed(this.error);
  @override
  List<Object?> get props => [error];
}

class FetchProjectsLoading extends FetchProjectsState {}

class FetchProjectsInitial extends FetchProjectsState {}
