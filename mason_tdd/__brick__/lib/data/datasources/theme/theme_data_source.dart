import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeDataSources extends Cubit<bool> {
  ThemeDataSources() : super(false);

  void setTheme(bool isDarkTheme) => emit(isDarkTheme);
}

// enum ThemeType {
//   dark,
//   light,
// }
