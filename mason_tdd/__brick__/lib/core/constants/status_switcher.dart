import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/response/api_response.dart';
import '/config/response/status.dart';
import '/core/utils/app_images.dart';
import '/core/utils/extensions.dart';

class StatusSwitcher<T> extends StatelessWidget {
  final ApiResponse<T> response;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context, String message)? onError;
  final Widget Function(BuildContext context, T data) onCompleted;

  const StatusSwitcher({
    super.key,
    required this.response,
    this.onLoading,
    this.onError,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    switch (response.status) {
      case Status.LOADING:
        return onLoading != null
            ? onLoading!(context)
            : Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: context.theme.colorScheme.primary,
                  valueColor: AlwaysStoppedAnimation(
                    context.theme.colorScheme.onPrimary,
                  ),
                ),
              );
      case Status.ERROR:
        return onError != null
            ? onError!(context, response.message)
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    response.message,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              );
      case Status.COMPLETED:
        if (response.data == null ||
            (response.data is Iterable &&
                (response.data as Iterable).isEmpty)) {
          return buildNoData(context);
        }
        return onCompleted(context, response.data);
      default:
        return Container();
    }
  }
}

Widget buildNoData(
  BuildContext context, {
  String? title,
  bool isSecondLine = false,
  String? secondLineText,
}) => Container(
  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
  child: Center(
    child: TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        final safeOpacity = value.clamp(0.0, 1.0);
        return Opacity(
          opacity: safeOpacity,
          child: Transform.scale(
            scale: value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.chatEmptyIcon,
                  width: 100.w,
                  height: 100.h,
                ),
                21.verticalSpace,
                Text(
                  title ?? "There's nothing here",
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                if (isSecondLine) ...[
                  11.verticalSpace,
                  Text(
                    secondLineText ?? '',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    ),
  ),
);
