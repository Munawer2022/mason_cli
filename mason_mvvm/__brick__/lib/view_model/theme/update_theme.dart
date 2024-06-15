import '/resource/global.dart';
import '/view_model/local/insecure_local_storage.dart';

import 'theme_view_model.dart';

class UpdateTheme {
  final ThemeViewModel _theme;
  final InsecureLocalStorage _localStorage;

  UpdateTheme(this._theme, this._localStorage);

  Future<void> updateTheme(bool isDarkTheme) {
    _theme.setTheme(isDarkTheme);
    return _localStorage.setBool(key: themeKey, value: isDarkTheme);
  }
}
