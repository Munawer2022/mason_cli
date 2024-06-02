import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Utils {
  void showErrorBanner(String text) {
    var materialBanner = MaterialBanner(
      elevation: 1,
      backgroundColor: Colors.grey.shade200,
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            MyApp.scaffoldMessengerKey.currentState!
                .hideCurrentMaterialBanner();
          },
          child: Text('Dismiss'),
        ),
      ],
    );

    // Use the ScaffoldMessengerKey to hide any current MaterialBanner and show a new one
    MyApp.scaffoldMessengerKey.currentState!
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  static snackbar(text, context) {
    var snackBar = SnackBar(
      backgroundColor: Colors.green.shade300,
      content: Text(
        text,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static errorSnackbar(text, context) {
    var snackBar = SnackBar(
      backgroundColor: Colors.red.shade300,
      content: Text(
        text,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void printWarning(text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(text) {
  print('\x1B[31m$text\x1B[0m');
}

void printInfo(text) {
  print('\x1B[34m$text\x1B[0m');
}

void printSuccess(text) {
  print('\x1B[32m$text\x1B[0m');
}
// themeData(BuildContext context) => Theme.of(context);

extension ThemeExtension on BuildContext {
  ThemeData get themeExtension => Theme.of(this);
}

extension NameSplitExtension on String {
  String get nameSplitExtension => this.split(" ").first;
}

void setCustomSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: true,
    systemStatusBarContrastEnforced: true,
  ));
}
