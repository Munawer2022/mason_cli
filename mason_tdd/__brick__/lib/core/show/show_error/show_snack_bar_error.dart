import 'package:flutter/material.dart';
import '/core/global.dart';

mixin ShowSnackBarError {
  void showErrorSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      // backgroundColor: Colors.grey.shade800,
      action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () => GlobalConstants.scaffoldMessengerKey.currentState!
              .hideCurrentSnackBar()),
    );

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
