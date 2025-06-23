import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/app_images.dart';
import '/core/utils/extensions.dart';

abstract class CustomAppBar {
  static AppBar appBar({
    required BuildContext context,
    required String title,
    bool leading = true,
    List<Widget>? actions,
    double toolbarHeight = 56,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    Widget? leadingIcon,
    Widget? titleWidget,
    bool? centerTitle,
  }) => AppBar(
    scrolledUnderElevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: backgroundColor ?? context.theme.scaffoldBackgroundColor,
    elevation: 0,
    centerTitle: centerTitle ?? true,
    bottom: bottom,
    toolbarHeight: toolbarHeight,
    actions: actions,
    leadingWidth: 80.w,
    leading:
        leadingIcon ??
        (leading
            ? IconButton(
                padding: EdgeInsets.all(14.r),
                style: IconButton.styleFrom(
                  backgroundColor: context
                      .theme
                      .iconButtonTheme
                      .style
                      ?.backgroundColor
                      ?.resolve({}),
                ),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  Icons.arrow_back_ios_new,
                  color: context.theme.iconTheme.color,
                  height: 14.h,
                  width: 14.w,
                ),
              )
            : null),
    title:
        titleWidget ??
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
    // ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600)),
  );
}
