import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton {
 static ElevatedButton getButton({
    required Widget? child,
    required void Function()? onPressed,
    double? width,
    double? height,
    Color? color,
    double? radius,
    bool loading = false,
  }) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius?.r ?? 10.0.r),
              ),
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              backgroundColor: color ?? Colors.blue,
              minimumSize:
                  Size(width?.w ?? double.infinity.w, height?.h ?? 50.0.h)),
          onPressed: loading == true ? null : onPressed,
          child: loading
              ? const CircularProgressIndicator.adaptive(
                  backgroundColor:
                      Colors.white,
                )
              : child);
 
}
