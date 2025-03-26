import 'package:flutter_bloc/flutter_bloc.dart';

class NameValidationCubit extends Cubit<String?> {
  NameValidationCubit() : super(null);

  void showError(String? error) {
    emit(error);
  }
}
