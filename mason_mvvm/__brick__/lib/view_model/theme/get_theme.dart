import '/resource/global.dart';

import '/view_model/local/insecure_local_storage.dart';

import 'theme_view_model.dart';

class GetTheme {
  final InsecureLocalStorage _localStorage;
  final ThemeViewModel _theme;

  GetTheme(
    this._localStorage,
    this._theme,
  );

  Future<void> getTheme() async => _localStorage.getBool(key: themeKey).then(
    {{#isFlutterBloc}}
        (isDarkTheme) => _theme.setTheme(isDarkTheme),
    {{/isFlutterBloc}}
        {{#isBloc}}
        (isDarkTheme) => _theme.add(SetTheme(isDarkTheme: isDarkTheme)),
        {{/isBloc}}
      );
}
