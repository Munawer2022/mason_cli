import '/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CustomAppBar {
  static AppBar appBar(
          {required BuildContext context,
          required String title,
          bool leading = true,
          List<Widget>? actions}) =>
      AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: actions,
        leading: leading
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded))
            : null,
        title: Text(title,
            style: context.textTheme.labelLarge?.copyWith(fontSize: 24.sp)),
      );
}
