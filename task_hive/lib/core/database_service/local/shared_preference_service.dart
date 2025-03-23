import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferenceService {
//   SharedPreferences? _prefsInstance;

//   Future<SharedPreferences> getInstance() async {
//     if (_prefsInstance != null) {
//       return _prefsInstance!;
//     }
//     _prefsInstance = await SharedPreferences.getInstance();
//     return _prefsInstance!;
//   }
// }
class SharedPreferenceService {
  SharedPreferences? _prefsInstance;
  static final SharedPreferenceService _instance =
      SharedPreferenceService._internal();

  factory SharedPreferenceService() {
    return _instance;
  }

  SharedPreferenceService._internal();

  Future<SharedPreferences> getInstance() async {
    if (_prefsInstance != null) {
      return _prefsInstance!;
    }

    try {
      _prefsInstance = await SharedPreferences.getInstance();
      return _prefsInstance!;
    } catch (e) {
      throw Exception('Failed to initialize SharedPreferences: $e');
    }
  }

  Future<bool> setBool(String key, bool value) async {
    final prefs = await getInstance();
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await getInstance();
    return prefs.getBool(key);
  }

  Future<bool> setString(String key, String value) async {
    final prefs = await getInstance();
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await getInstance();
    return prefs.getString(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await getInstance();
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    final prefs = await getInstance();
    return prefs.clear();
  }
}
