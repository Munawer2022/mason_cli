import 'package:flutter/material.dart';
import 'login_initial_params.dart';
import 'login_page.dart';
import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';

// is page say navigate kr nay ky liya
class LoginNavigator {
  LoginNavigator(this.navigator);
  @override
  late BuildContext context;

  @override
  AppNavigator navigator;
}

//is page pr navigate pr nay ky liya
mixin LoginRoute {
  openLogin(LoginInitialParams initialParams) {
    navigator.push(context, LoginPage(cubit: getIt(param1: initialParams)));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
