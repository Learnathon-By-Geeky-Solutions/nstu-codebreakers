import 'package:flutter_bloc/flutter_bloc.dart';

class EmailValidationCubit extends Cubit<String?> {
  EmailValidationCubit() : super(null);

  void showError(String? error) {
    emit(error);
  }
}
