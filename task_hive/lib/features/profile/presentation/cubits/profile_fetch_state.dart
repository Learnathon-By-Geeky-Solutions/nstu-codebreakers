import 'package:equatable/equatable.dart';

import '../../domain/entity/profile_info.dart';

class ProfileFetchState extends Equatable {
  const ProfileFetchState();

  @override
  List<Object> get props => [];
}

class ProfileFetchInitial extends ProfileFetchState {}

class ProfileFetchLoading extends ProfileFetchState {}

class ProfileFetchSuccess extends ProfileFetchState {
  final ProfileInfo userData;
  const ProfileFetchSuccess({required this.userData});
  @override
  List<Object> get props => [userData];
}

class ProfileFetchError extends ProfileFetchState {
  final String error;
  const ProfileFetchError({required this.error});
  @override
  List<Object> get props => [error];
}
