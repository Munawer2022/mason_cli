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
  final void Function()? onTap;

  const StatusSwitcher({
    super.key,
    required this.response,
    this.onLoading,
    this.onError,
    required this.onCompleted,
    this.onTap,
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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated error icon with gradient background
                      Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              context.theme.colorScheme.error.withOpacity(0.1),
                              context.theme.colorScheme.error.withOpacity(0.05),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.theme.colorScheme.error
                                  .withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  context.theme.colorScheme.error,
                                  context.theme.colorScheme.error.withOpacity(
                                    0.8,
                                  ),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: context.theme.colorScheme.error
                                      .withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.sentiment_dissatisfied_rounded,
                              color: Colors.white,
                              size: 40.sp,
                            ),
                          ),
                        ),
                      ),
                      32.verticalSpace,
                      // Error title with gradient text effect
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            context.theme.colorScheme.error,
                            context.theme.colorScheme.error.withOpacity(0.7),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'Oops! Something went wrong',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      16.verticalSpace,
                      // Error message in a styled container
                      Text(
                        response.message,
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.8),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      32.verticalSpace,
                      // Modern retry button with gradient
                      // Container(
                      //   decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       begin: Alignment.centerLeft,
                      //       end: Alignment.centerRight,
                      //       colors: [
                      //         context.theme.colorScheme.error,
                      //         context.theme.colorScheme.error.withOpacity(0.8),
                      //       ],
                      //     ),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: context.theme.colorScheme.error
                      //             .withOpacity(0.3),
                      //         blurRadius: 15,
                      //         offset: const Offset(0, 6),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Material(
                      //     color: Colors.transparent,
                      //     child: InkWell(
                      //       onTap: onTap,
                      //       borderRadius: BorderRadius.circular(16.r),
                      //       child: Container(
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: 32.w, vertical: 16.h),
                      //         child: Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             Icon(
                      //               Icons.refresh_rounded,
                      //               color: Colors.white,
                      //               size: 20.sp,
                      //             ),
                      //             12.horizontalSpace,
                      //             Text(
                      //               'Try Again',
                      //               style: TextStyle(
                      //                 fontSize: 16.sp,
                      //                 fontWeight: FontWeight.w600,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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
                // Image.asset(AppImages.chatEmptyIcon,
                //     color: context.isDarkMode
                //         ? Colors.white
                //         : Colors.black,
                //     width: 100.w,
                //     height: 100.h),
                // 21.verticalSpace,
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
