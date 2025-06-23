import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

abstract class AppButton {
  static Widget getButton({
    required BuildContext context,
    String? text,
    required void Function()? onPressed,
    double? width,
    double? height,
    Color? textColor,
    double? radius,
    bool loading = false,
    Gradient? gradient,
    TextStyle? style,
    Color? backgroundColor,
    Widget? child,
  }) {
    final bool isDisabled = onPressed == null;

    return Container(
      width: width?.w ?? double.infinity.w,
      height: height?.h ?? 50.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius?.r ?? 100.0.r),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDisabled
              ? context.theme.colorScheme.onSurface
              : (backgroundColor ?? context.theme.colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius?.r ?? 100.0.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          minimumSize: Size(double.infinity.w, 50.0.h),
        ),
        onPressed: loading ? null : onPressed,
        child: loading
            ? CircularProgressIndicator.adaptive(
                backgroundColor: context.theme.colorScheme.secondary,
              )
            : child ??
                  Text(
                    text!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        style ??
                        context.textTheme.titleSmall?.copyWith(
                          color: textColor,
                        ),
                  ),
      ),
    );
  }

  static Widget getOutlinedButton({
    required BuildContext context,
    Widget? child,
    String? text,
    required void Function()? onPressed,
    double? width,
    double? height,
    Color? textColor,
    Color? borderColor,
    double? radius,
    bool loading = false,
    TextStyle? textStyle,
  }) {
    final bool isDisabled = onPressed == null;

    return SizedBox(
      width: width?.w ?? double.infinity.w,
      height: height?.h ?? 50.0.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: context.theme.canvasColor,
          side: BorderSide(
            color: isDisabled
                ? context.theme.colorScheme.outline
                : (borderColor ?? context.theme.colorScheme.primary),
            width: 1.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius?.r ?? 100.0.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          minimumSize: Size(double.infinity.w, 50.0.h),
        ),
        onPressed: loading ? null : onPressed,
        child: loading
            ? CircularProgressIndicator.adaptive(
                backgroundColor: context.theme.colorScheme.secondary,
              )
            : child ??
                  Text(
                    text!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textStyle ?? context.textTheme.titleSmall,
                  ),
      ),
    );
  }
}
