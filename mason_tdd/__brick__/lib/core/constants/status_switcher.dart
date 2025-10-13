import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/response/api_response.dart';
import '/config/response/status.dart';
import '/core/utils/extensions.dart';
import '/core/widgets/app_button.dart';

/// Configuration class for customizing StatusSwitcher appearance and behavior
class StatusSwitcherConfig {
  final Duration animationDuration;
  final Curve animationCurve;
  final bool showRetryButton;
  final String retryButtonText;
  final IconData errorIcon;
  final IconData retryIcon;
  final String defaultErrorTitle;
  final String defaultNoDataTitle;
  final EdgeInsets containerMargin;
  final double iconSize;
  final double titleFontSize;
  final double messageFontSize;

  const StatusSwitcherConfig({
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOutBack,
    this.showRetryButton = true,
    this.retryButtonText = 'Try Again',
    this.errorIcon = Icons.sentiment_dissatisfied_rounded,
    this.retryIcon = Icons.refresh_rounded,
    this.defaultErrorTitle = 'Oops! Something went wrong',
    this.defaultNoDataTitle = "There's nothing here",
    this.containerMargin = const EdgeInsets.symmetric(horizontal: 20),
    this.iconSize = 40,
    this.titleFontSize = 24,
    this.messageFontSize = 16,
  });

  StatusSwitcherConfig copyWith({
    Duration? animationDuration,
    Curve? animationCurve,
    bool? showRetryButton,
    String? retryButtonText,
    IconData? errorIcon,
    IconData? retryIcon,
    String? defaultErrorTitle,
    String? defaultNoDataTitle,
    EdgeInsets? containerMargin,
    double? iconSize,
    double? titleFontSize,
    double? messageFontSize,
  }) {
    return StatusSwitcherConfig(
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      showRetryButton: showRetryButton ?? this.showRetryButton,
      retryButtonText: retryButtonText ?? this.retryButtonText,
      errorIcon: errorIcon ?? this.errorIcon,
      retryIcon: retryIcon ?? this.retryIcon,
      defaultErrorTitle: defaultErrorTitle ?? this.defaultErrorTitle,
      defaultNoDataTitle: defaultNoDataTitle ?? this.defaultNoDataTitle,
      containerMargin: containerMargin ?? this.containerMargin,
      iconSize: iconSize ?? this.iconSize,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      messageFontSize: messageFontSize ?? this.messageFontSize,
    );
  }
}

/// Main StatusSwitcher widget with improved architecture
class StatusSwitcher<T> extends StatelessWidget {
  final ApiResponse<T> response;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context, String message)? onError;
  final Widget Function(BuildContext context, T data) onCompleted;
  final VoidCallback? onRetry;
  final StatusSwitcherConfig config;
  final String? customErrorTitle;
  final String? customNoDataTitle;
  final String? customNoDataSubtitle;
  final bool Function(T data)? isDataEmpty;

  const StatusSwitcher({
    super.key,
    required this.response,
    this.onLoading,
    this.onError,
    required this.onCompleted,
    this.onRetry,
    this.config = const StatusSwitcherConfig(),
    this.customErrorTitle,
    this.customNoDataTitle,
    this.customNoDataSubtitle,
    this.isDataEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildStatusWidget(context),
    );
  }

  Widget _buildStatusWidget(BuildContext context) {
    switch (response.status) {
      case Status.LOADING:
        return onLoading?.call(context) ?? _DefaultLoadingWidget();
      case Status.ERROR:
        return onError?.call(context, response.message) ??
            _DefaultErrorWidget(
              message: response.message,
              onRetry: onRetry,
              config: config,
              customTitle: customErrorTitle,
            );
      case Status.COMPLETED:
        if (_isDataEmpty(response.data)) {
          return _DefaultNoDataWidget(
            config: config,
            title: customNoDataTitle,
            subtitle: customNoDataSubtitle,
          );
        }
        return onCompleted(context, response.data);
      default:
        return const SizedBox.shrink();
    }
  }

  bool _isDataEmpty(T? data) {
    if (isDataEmpty != null && data != null) {
      return isDataEmpty!(data);
    }

    if (data == null) return true;
    if (data is Iterable) return data.isEmpty;
    if (data is String) return data.isEmpty;
    if (data is Map) return data.isEmpty;

    return false;
  }
}

/// Default loading widget component
class _DefaultLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: context.theme.colorScheme.primary,
        valueColor: AlwaysStoppedAnimation(context.theme.colorScheme.onPrimary),
      ),
    );
  }
}

/// Default error widget component
class _DefaultErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final StatusSwitcherConfig config;
  final String? customTitle;

  const _DefaultErrorWidget({
    required this.message,
    this.onRetry,
    required this.config,
    this.customTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: config.containerMargin.horizontal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildErrorIcon(context),
            32.verticalSpace,
            _buildErrorTitle(context),
            16.verticalSpace,
            _buildErrorMessage(context),
            if (config.showRetryButton && onRetry != null) ...[
              32.verticalSpace,
              _buildRetryButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorIcon(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: config.animationDuration,
      curve: config.animationCurve,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
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
                  color: context.theme.colorScheme.error.withOpacity(0.2),
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
                      context.theme.colorScheme.error.withOpacity(0.8),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.theme.colorScheme.error.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  config.errorIcon,
                  color: Colors.white,
                  size: config.iconSize.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorTitle(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          context.theme.colorScheme.error,
          context.theme.colorScheme.error.withOpacity(0.7),
        ],
      ).createShader(bounds),
      child: Text(
        customTitle ?? config.defaultErrorTitle,
        style: context.textTheme.headlineSmall?.copyWith(
          fontSize: config.titleFontSize.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return Text(
      message,
      style: context.textTheme.bodyLarge?.copyWith(
        fontSize: config.messageFontSize.sp,
        color: context.theme.colorScheme.onSurface.withOpacity(0.8),
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: config.animationDuration,
      curve: config.animationCurve,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: AppButton.getButton(
            context: context,
            text: config.retryButtonText,
            onPressed: onRetry,
            backgroundColor: context.theme.colorScheme.error,
            textColor: Colors.white,
            radius: 16,
            height: 50,
            elevation: 6,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            icon: Icon(config.retryIcon, color: Colors.white, size: 20.sp),
          ),
        );
      },
    );
  }
}

/// Default no data widget component
class _DefaultNoDataWidget extends StatelessWidget {
  final StatusSwitcherConfig config;
  final String? title;
  final String? subtitle;

  const _DefaultNoDataWidget({required this.config, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Center(
        child: TweenAnimationBuilder<double>(
          duration: config.animationDuration,
          curve: config.animationCurve,
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
                    // Uncomment and customize if you have an empty state image
                    // Image.asset(
                    //   AppImages.chatEmptyIcon,
                    //   color: context.isDarkMode ? Colors.white : Colors.black,
                    //   width: 100.w,
                    //   height: 100.h,
                    // ),
                    // 21.verticalSpace,
                    Text(
                      title ?? config.defaultNoDataTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    if (subtitle != null) ...[
                      11.verticalSpace,
                      Text(
                        subtitle!,
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
  }
}

/// Extension for easier StatusSwitcher usage
extension StatusSwitcherExtension<T> on ApiResponse<T> {
  Widget toWidget({
    required Widget Function(BuildContext context, T data) onCompleted,
    Widget Function(BuildContext context)? onLoading,
    Widget Function(BuildContext context, String message)? onError,
    VoidCallback? onRetry,
    StatusSwitcherConfig config = const StatusSwitcherConfig(),
    String? customErrorTitle,
    String? customNoDataTitle,
    String? customNoDataSubtitle,
    bool Function(T data)? isDataEmpty,
  }) {
    return StatusSwitcher<T>(
      response: this,
      onCompleted: onCompleted,
      onLoading: onLoading,
      onError: onError,
      onRetry: onRetry,
      config: config,
      customErrorTitle: customErrorTitle,
      customNoDataTitle: customNoDataTitle,
      customNoDataSubtitle: customNoDataSubtitle,
      isDataEmpty: isDataEmpty,
    );
  }
}
