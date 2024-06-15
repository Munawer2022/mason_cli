import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeViewModel extends Cubit<bool> {
  ThemeViewModel() : super(false);

  void setTheme(bool isDarkTheme) => emit(isDarkTheme);
}
