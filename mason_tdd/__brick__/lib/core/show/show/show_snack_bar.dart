import 'package:flutter/material.dart';
import '/core/constants/global.dart';

mixin ShowSnackBarSuccess {
  void showSuccessSnackBar(String message) {
    var snackBar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,

        // backgroundColor: Colors.grey.shade800,
        action: SnackBarAction(
            label: 'DISMISS',
            textColor: Colors.white,
            onPressed: () => GlobalConstants.scaffoldMessengerKey.currentState!
                .hideCurrentSnackBar()));

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

mixin ShowSnackBarError {
  void showErrorSnackBar(String message) {
    var snackBar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xffFF0000).withOpacity(.7),
        behavior: SnackBarBehavior.floating,

        // backgroundColor: Colors.grey.shade800,
        action: SnackBarAction(
            label: 'DISMISS',
            textColor: Colors.white,
            onPressed: () => GlobalConstants.scaffoldMessengerKey.currentState!
                .hideCurrentSnackBar()));

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
