import 'package:shared_preferences/shared_preferences.dart';

const String THEME_PREF = 'AppTheme';
enum Themes { DARK, LIGHT, SYSTEM }

class SharedPreferenceService {
  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark",
    Themes.LIGHT: "Light",
    Themes.SYSTEM: "System"
  };

  setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_PREF, theme);
  }

  Future<String> getTheme() async {
    String theme = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(THEME_PREF));
    if (theme != null) {
      return theme;
    } else {
      await SharedPreferences.getInstance()
          .then((prefs) => prefs.setString(THEME_PREF, themes[Themes.SYSTEM]));
      return themes[Themes.SYSTEM];
    }
  }

  addStringToSF(String name, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
  }

  Future getStringValuesSF(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(name);
    return stringValue;
  }

  addBoolToSF(String name, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(name, value);
  }

  Future<bool> getBoolValuesSF(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(name);
  }
}
