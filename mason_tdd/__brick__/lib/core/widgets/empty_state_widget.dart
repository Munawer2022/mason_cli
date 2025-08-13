import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback? onActionPressed;
  final String? actionText;
  final EmptyStateType type;
  final EdgeInsets? padding;
  final bool showAction;

  const EmptyStateWidget({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.customIcon,
    this.onActionPressed,
    this.actionText,
    this.type = EmptyStateType.generic,
    this.padding,
    this.showAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(24.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(context),
            24.verticalSpace,
            if (title != null) ...[
              Text(
                title!,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
            ],
            if (message != null) ...[
              Text(
                message!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.colorScheme.onSurface.withOpacity(0.7),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
            ],
            if (showAction && onActionPressed != null) ...[
              _buildActionButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (customIcon != null) {
      return customIcon!;
    }

    final iconData = icon ?? _getDefaultIcon();
    final iconColor = _getIconColor(context);

    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: 60.sp, color: iconColor),
    );
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case EmptyStateType.noData:
        return Icons.inbox_outlined;
      case EmptyStateType.noInternet:
        return Icons.wifi_off_outlined;
      case EmptyStateType.error:
        return Icons.error_outline;
      case EmptyStateType.search:
        return Icons.search_off_outlined;
      case EmptyStateType.favorites:
        return Icons.favorite_border;
      case EmptyStateType.notifications:
        return Icons.notifications_none;
      case EmptyStateType.messages:
        return Icons.chat_bubble_outline;
      case EmptyStateType.generic:
      default:
        return Icons.inbox_outlined;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (type) {
      case EmptyStateType.noData:
        return context.theme.colorScheme.primary;
      case EmptyStateType.noInternet:
        return context.theme.colorScheme.error;
      case EmptyStateType.error:
        return context.theme.colorScheme.error;
      case EmptyStateType.search:
        return context.theme.colorScheme.secondary;
      case EmptyStateType.favorites:
        return Colors.red;
      case EmptyStateType.notifications:
        return context.theme.colorScheme.primary;
      case EmptyStateType.messages:
        return context.theme.colorScheme.secondary;
      case EmptyStateType.generic:
      default:
        return context.theme.colorScheme.primary;
    }
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: ElevatedButton(
        onPressed: onActionPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.primary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          actionText ?? _getDefaultActionText(),
          style: context.textTheme.labelLarge?.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  String _getDefaultActionText() {
    switch (type) {
      case EmptyStateType.noData:
        return 'Refresh';
      case EmptyStateType.noInternet:
        return 'Retry';
      case EmptyStateType.error:
        return 'Try Again';
      case EmptyStateType.search:
        return 'Clear Search';
      case EmptyStateType.favorites:
        return 'Browse Items';
      case EmptyStateType.notifications:
        return 'Check Later';
      case EmptyStateType.messages:
        return 'Start Chat';
      case EmptyStateType.generic:
      default:
        return 'Get Started';
    }
  }
}

enum EmptyStateType {
  generic,
  noData,
  noInternet,
  error,
  search,
  favorites,
  notifications,
  messages,
}

// Specialized Empty State Widgets
class NoDataWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRefresh;
  final IconData? icon;

  const NoDataWidget({
    super.key,
    this.title,
    this.message,
    this.onRefresh,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      type: EmptyStateType.noData,
      title: title ?? 'No Data Found',
      message: message ?? 'There are no items to display at the moment.',
      icon: icon,
      onActionPressed: onRefresh,
      actionText: 'Refresh',
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  const NoInternetWidget({super.key, this.title, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      type: EmptyStateType.noInternet,
      title: title ?? 'No Internet Connection',
      message:
          message ?? 'Please check your internet connection and try again.',
      onActionPressed: onRetry,
      actionText: 'Retry',
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorStateWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      type: EmptyStateType.error,
      title: title ?? 'Something Went Wrong',
      message: message ?? 'An error occurred. Please try again.',
      icon: icon,
      onActionPressed: onRetry,
      actionText: 'Try Again',
    );
  }
}

class SearchEmptyWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onClearSearch;

  const SearchEmptyWidget({
    super.key,
    this.title,
    this.message,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      type: EmptyStateType.search,
      title: title ?? 'No Results Found',
      message: message ?? 'Try adjusting your search terms or filters.',
      onActionPressed: onClearSearch,
      actionText: 'Clear Search',
    );
  }
}
