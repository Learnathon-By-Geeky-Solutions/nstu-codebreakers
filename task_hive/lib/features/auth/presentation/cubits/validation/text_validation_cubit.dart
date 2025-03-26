import 'package:flutter_bloc/flutter_bloc.dart';

class TextVisibilityCubit extends Cubit<bool> {
  TextVisibilityCubit() : super(true);
  void changeVisibility() {
    emit(!state);
  }
}
