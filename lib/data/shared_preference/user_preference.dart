import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  static final String _kThemeDataPrefs = "themePrefs";

  static Future<bool> getThemeDataPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kThemeDataPrefs) ?? false;
  }

  static Future<bool> setThemeDataPrefs(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kThemeDataPrefs, value);
  }
}
