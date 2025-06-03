import 'package:flutter_bloc/flutter_bloc.dart';

class OtpValidationCubit extends Cubit<String?> {
  OtpValidationCubit() : super(null);

  void showError(String? error) {
    emit(error);
  }
}
