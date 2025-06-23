import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/resource/global.dart';

mixin ShowMaterialBannerError {
  void showErrorMaterialBanner(String message) {
    var materialBanner = MaterialBanner(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      actions: [
        TextButton(
          onPressed: () =>
              scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner(),
          child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
        ),
      ],
    );

    scaffoldMessengerKey.currentState!
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  void showNoInternetConnectionMaterialBanner(String message) {
    final materialBanner = MaterialBanner(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      actions: [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(navigatorKey.currentContext!)
              .hideCurrentMaterialBanner(),
          child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
        ),
      ],
    );

    ScaffoldMessenger.of(navigatorKey.currentContext!)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }
}
