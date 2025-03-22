import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferences? _prefsInstance;

  Future<SharedPreferences> getInstance() async {
    if (_prefsInstance != null) {
      return _prefsInstance!;
    }
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance!;
  }
}
