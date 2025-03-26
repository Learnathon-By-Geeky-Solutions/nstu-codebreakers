import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordValidationCubit extends Cubit<String?> {
  PasswordValidationCubit() : super(null);

  void showError(String? error) {
    emit(error);
  }

  void confirmationError(String? error) {
    emit(error);
  }
}
