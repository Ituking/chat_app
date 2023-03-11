import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;

  static Future<void> setPrefsInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
  }
}
