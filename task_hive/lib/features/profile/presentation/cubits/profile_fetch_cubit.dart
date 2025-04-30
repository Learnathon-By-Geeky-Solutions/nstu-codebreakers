import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hive/features/profile/presentation/cubits/profile_fetch_state.dart';

import '../../domain/entity/profile_info.dart';
import '../../domain/use_case/profile_fetch_use_case.dart';

class ProfileFetchCubit extends Cubit<ProfileFetchState> {
  ProfileFetchCubit(this._profileFetchUseCase, this._updateProfileUseCase)
      : super(ProfileFetchInitial());
  final ProfileFetchUseCase _profileFetchUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  void fetchProfile(int userId) async {
    final result = await _profileFetchUseCase.call(userId);
    result.fold(
      (error) => emit(ProfileFetchError(error: error)),
      (profile) => emit(ProfileFetchSuccess(userData: profile)),
    );
  }

  void editProfile(ProfileInfo profileInfo) async {
    emit(ProfileFetchLoading());
    final result = await _updateProfileUseCase.call(profileInfo);
    result.fold(
      (error) => emit(ProfileFetchError(error: error)),
      (profile) => emit(ProfileFetchSuccess(userData: profile)),
    );
  }
}
