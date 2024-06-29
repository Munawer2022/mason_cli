import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
{{#isBloc}}
import 'theme_event.dart';

class ThemeViewModel extends Bloc<ThemeEvent, bool> {
  ThemeViewModel() : super(false) {
    on<SetTheme>(_setTheme);
  }

  void _setTheme(SetTheme event, Emitter<bool> emit) => emit(event.isDarkTheme);
}
{{/isBloc}}
{{#isFlutterBloc}}

class ThemeViewModel extends Cubit<bool> {
  ThemeViewModel() : super(false);

  void setTheme(bool isDarkTheme) => emit(isDarkTheme);
}
{{/isFlutterBloc}}
{{#isProvider}}

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void setTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }
}
{{/isProvider}}
