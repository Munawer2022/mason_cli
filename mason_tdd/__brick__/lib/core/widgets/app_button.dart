import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Enhanced abstract class for AppButton with improved functionality
abstract class AppButton {
  // Default values
  static const double _defaultHeight = 50.0;
  static const double _defaultRadius = 100.0;
  static const double _defaultBorderWidth = 1.0;
  static const EdgeInsets _defaultPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );

  /// Creates an elevated button with enhanced features
  static Widget getButton({
    required BuildContext context,
    String? text,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    // Dimensions
    double? width,
    double? height,
    EdgeInsets? padding,
    // Styling
    Color? textColor,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    double? radius,
    double? elevation,
    // Typography
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? fontWeight,
    // State
    bool loading = false,
    bool disabled = false,
    // Content
    Widget? child,
    Widget? icon,
    // Loading customization
    Color? loadingColor,
    double? loadingSize,
    // Accessibility
    String? tooltip,
    String? semanticLabel,
    // Animation
    Duration? animationDuration,
  }) {
    assert(
      text != null || child != null,
      'Either text or child must be provided',
    );

    final bool isDisabled = disabled || onPressed == null;
    final effectiveHeight = height?.h ?? _defaultHeight.h;
    final effectiveRadius = radius?.r ?? _defaultRadius.r;
    final effectivePadding = padding ?? _defaultPadding;

    Widget button = Container(
      width: width?.w ?? double.infinity,
      height: effectiveHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveRadius),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          backgroundColor: _getBackgroundColor(
            context,
            backgroundColor,
            disabledBackgroundColor,
            isDisabled,
          ),
          foregroundColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
          ),
          disabledBackgroundColor:
              disabledBackgroundColor ??
              context.theme.colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor:
              disabledTextColor ??
              context.theme.colorScheme.onSurface.withOpacity(0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: effectivePadding.horizontal / 2,
            vertical: effectivePadding.vertical / 2,
          ),
          minimumSize: Size(double.infinity, effectiveHeight),
          animationDuration:
              animationDuration ?? const Duration(milliseconds: 200),
        ),
        onPressed: loading ? null : onPressed,
        onLongPress: loading ? null : onLongPress,
        child: _buildButtonContent(
          context: context,
          loading: loading,
          text: text,
          child: child,
          icon: icon,
          textStyle: textStyle,
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
          ),
          loadingColor: loadingColor,
          loadingSize: loadingSize,
        ),
      ),
    );

    // Add tooltip if provided
    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    // Add semantic label if provided
    if (semanticLabel != null) {
      button = Semantics(label: semanticLabel, child: button);
    }

    return button;
  }

  /// Creates an outlined button with enhanced features
  static Widget getOutlinedButton({
    required BuildContext context,
    String? text,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    // Dimensions
    double? width,
    double? height,
    EdgeInsets? padding,
    // Styling
    Color? textColor,
    Color? backgroundColor,
    Color? borderColor,
    Color? disabledBorderColor,
    Color? disabledTextColor,
    double? radius,
    double? borderWidth,
    // Typography
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? fontWeight,
    // State
    bool loading = false,
    bool disabled = false,
    // Content
    Widget? child,
    Widget? icon,
    // Loading customization
    Color? loadingColor,
    double? loadingSize,
    // Accessibility
    String? tooltip,
    String? semanticLabel,
    // Animation
    Duration? animationDuration,
  }) {
    assert(
      text != null || child != null,
      'Either text or child must be provided',
    );

    final bool isDisabled = disabled || onPressed == null;
    final effectiveHeight = height?.h ?? _defaultHeight.h;
    final effectiveRadius = radius?.r ?? _defaultRadius.r;
    final effectivePadding = padding ?? _defaultPadding;
    final effectiveBorderWidth = borderWidth?.w ?? _defaultBorderWidth.w;

    Widget button = SizedBox(
      width: width?.w ?? double.infinity,
      height: effectiveHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
          ),
          disabledForegroundColor:
              disabledTextColor ??
              context.theme.colorScheme.onSurface.withOpacity(0.38),
          side: BorderSide(
            color: _getBorderColor(
              context,
              borderColor,
              disabledBorderColor,
              isDisabled,
            ),
            width: effectiveBorderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: effectivePadding.horizontal / 2,
            vertical: effectivePadding.vertical / 2,
          ),
          minimumSize: Size(double.infinity, effectiveHeight),
          animationDuration:
              animationDuration ?? const Duration(milliseconds: 200),
        ),
        onPressed: loading ? null : onPressed,
        onLongPress: loading ? null : onLongPress,
        child: _buildButtonContent(
          context: context,
          loading: loading,
          text: text,
          child: child,
          icon: icon,
          textStyle: textStyle,
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
          ),
          loadingColor: loadingColor,
          loadingSize: loadingSize,
        ),
      ),
    );

    // Add tooltip if provided
    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    // Add semantic label if provided
    if (semanticLabel != null) {
      button = Semantics(label: semanticLabel, child: button);
    }

    return button;
  }

  /// Builds the content of the button (text, icon, loading indicator)
  static Widget _buildButtonContent({
    required BuildContext context,
    required bool loading,
    String? text,
    Widget? child,
    Widget? icon,
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    Color? loadingColor,
    double? loadingSize,
  }) {
    if (loading) {
      return SizedBox(
        width: (loadingSize ?? 20.0).w,
        height: (loadingSize ?? 20.0).h,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(
            loadingColor ?? textColor ?? context.theme.colorScheme.onPrimary,
          ),
        ),
      );
    }

    if (child != null) return child;

    final List<Widget> children = [];

    if (icon != null) {
      children.add(icon);
      if (text != null) {
        children.add(SizedBox(width: 8.w));
      }
    }

    if (text != null) {
      children.add(
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: _buildTextStyle(
              context,
              textStyle,
              fontSize,
              fontWeight,
              textColor,
            ),
          ),
        ),
      );
    }

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return children.length == 1
        ? children.first
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
  }

  /// Builds the text style for the button
  static TextStyle _buildTextStyle(
    BuildContext context,
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
  ) {
    final baseStyle = textStyle ?? context.textTheme.titleSmall;

    return baseStyle?.copyWith(
          fontSize: fontSize?.sp,
          fontWeight: fontWeight,
          color: textColor,
        ) ??
        TextStyle(
          fontSize: fontSize?.sp ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor,
        );
  }

  /// Gets the background color based on state
  static Color _getBackgroundColor(
    BuildContext context,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    bool isDisabled,
  ) {
    if (isDisabled) {
      return disabledBackgroundColor ??
          context.theme.colorScheme.onSurface.withOpacity(0.12);
    }
    return backgroundColor ?? context.theme.colorScheme.primary;
  }

  /// Gets the text color based on state
  static Color _getTextColor(
    BuildContext context,
    Color? textColor,
    Color? disabledTextColor,
    bool isDisabled,
  ) {
    if (isDisabled) {
      return disabledTextColor ??
          context.theme.colorScheme.onSurface.withOpacity(0.38);
    }
    return textColor ?? context.theme.colorScheme.onPrimary;
  }

  /// Gets the border color based on state
  static Color _getBorderColor(
    BuildContext context,
    Color? borderColor,
    Color? disabledBorderColor,
    bool isDisabled,
  ) {
    if (isDisabled) {
      return disabledBorderColor ??
          context.theme.colorScheme.onSurface.withOpacity(0.12);
    }
    return borderColor ?? context.theme.colorScheme.primary;
  }
}
