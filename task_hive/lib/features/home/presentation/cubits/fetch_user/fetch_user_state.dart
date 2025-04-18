import 'package:equatable/equatable.dart';
import 'package:task_hive/features/home/domain/entities/home_user_entity.dart';

class FetchUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserInitial extends FetchUserState {}

class FetchUserLoading extends FetchUserState {}

class FetchUserSuccess extends FetchUserState {
  final HomePageUserEntity userData;
  FetchUserSuccess(this.userData);

  @override
  List<Object?> get props => [userData];
}

class FetchUserFailed extends FetchUserState {
  final String error;
  FetchUserFailed(this.error);

  @override
  List<Object?> get props => [error];
}
