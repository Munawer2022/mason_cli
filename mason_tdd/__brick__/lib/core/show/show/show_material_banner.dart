import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/global.dart';

mixin ShowMaterialBannerSuccess {
  void showSuccessMaterialBanner(String message) {
    var materialBanner = MaterialBanner(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
              onPressed: () => GlobalConstants
                  .scaffoldMessengerKey.currentState!
                  .hideCurrentMaterialBanner(),
              child:
                  const Text('DISMISS', style: TextStyle(color: Colors.white)))
        ]);

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  void showNoInternetConnectionMaterialBanner(String message) {
    final materialBanner = MaterialBanner(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
              onPressed: () => ScaffoldMessenger.of(
                      GlobalConstants.navigatorKey.currentContext!)
                  .hideCurrentMaterialBanner(),
              child:
                  const Text('DISMISS', style: TextStyle(color: Colors.white)))
        ]);

    ScaffoldMessenger.of(GlobalConstants.navigatorKey.currentContext!)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }
}

mixin ShowMaterialBannerError {
  void showErrorMaterialBanner(String message) {
    var materialBanner = MaterialBanner(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xffFF0000).withOpacity(.7),
        actions: [
          TextButton(
              onPressed: () => GlobalConstants
                  .scaffoldMessengerKey.currentState!
                  .hideCurrentMaterialBanner(),
              child:
                  const Text('DISMISS', style: TextStyle(color: Colors.white)))
        ]);

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  void showNoInternetConnectionMaterialBanner(String message) {
    final materialBanner = MaterialBanner(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xffFF0000).withOpacity(.7),
        actions: [
          TextButton(
              onPressed: () => ScaffoldMessenger.of(
                      GlobalConstants.navigatorKey.currentContext!)
                  .hideCurrentMaterialBanner(),
              child:
                  const Text('DISMISS', style: TextStyle(color: Colors.white)))
        ]);

    ScaffoldMessenger.of(GlobalConstants.navigatorKey.currentContext!)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }
}
