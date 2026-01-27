import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Simple, theme-aware custom button widget
abstract class AppButton {
  /// Creates an elevated button with loading state support
  static Widget getButton({
    required BuildContext context,
    String? text,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    // Dimensions
    double? width,
    double? height,
    // Styling overrides
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    // Typography
    TextStyle? textStyle,
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
  }) {
    assert(
      text != null || child != null,
      'Either text or child must be provided',
    );

    final isDisabled = disabled || onPressed == null || loading;
    final theme = Theme.of(context);
    final buttonStyle = theme.elevatedButtonTheme.style;

    Widget button = SizedBox(
      width: width?.w ?? double.infinity,
      height: height?.h,
      child: ElevatedButton(
        style: buttonStyle?.copyWith(
          backgroundColor: backgroundColor != null
              ? WidgetStateProperty.all(backgroundColor)
              : null,
          foregroundColor: foregroundColor != null
              ? WidgetStateProperty.all(foregroundColor)
              : null,
          elevation: elevation != null
              ? WidgetStateProperty.all(elevation)
              : null,
        ),
        onPressed: isDisabled ? null : onPressed,
        onLongPress: isDisabled ? null : onLongPress,
        child: _buildButtonContent(
          context: context,
          loading: loading,
          text: text,
          child: child,
          icon: icon,
          textStyle: textStyle ?? buttonStyle?.textStyle?.resolve({}),
          loadingColor: loadingColor,
          loadingSize: loadingSize,
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    if (semanticLabel != null) {
      button = Semantics(label: semanticLabel, child: button);
    }

    return button;
  }

  /// Creates an outlined button with loading state support
  static Widget getOutlinedButton({
    required BuildContext context,
    String? text,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    // Dimensions
    double? width,
    double? height,
    // Styling overrides
    Color? foregroundColor,
    Color? borderColor,
    double? borderWidth,
    // Typography
    TextStyle? textStyle,
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
  }) {
    assert(
      text != null || child != null,
      'Either text or child must be provided',
    );

    final isDisabled = disabled || onPressed == null || loading;
    final theme = Theme.of(context);
    final buttonStyle = theme.outlinedButtonTheme.style;

    Widget button = SizedBox(
      width: width?.w ?? double.infinity,
      height: height?.h,
      child: OutlinedButton(
        style: buttonStyle?.copyWith(
          foregroundColor: foregroundColor != null
              ? WidgetStateProperty.all(foregroundColor)
              : null,
          side: borderColor != null || borderWidth != null
              ? WidgetStateProperty.all(
                  BorderSide(
                    color: borderColor ?? theme.colorScheme.primary,
                    width: borderWidth ?? 1.0,
                  ),
                )
              : null,
        ),
        onPressed: isDisabled ? null : onPressed,
        onLongPress: isDisabled ? null : onLongPress,
        child: _buildButtonContent(
          context: context,
          loading: loading,
          text: text,
          child: child,
          icon: icon,
          textStyle: textStyle ?? buttonStyle?.textStyle?.resolve({}),
          loadingColor: loadingColor,
          loadingSize: loadingSize,
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    if (semanticLabel != null) {
      button = Semantics(label: semanticLabel, child: button);
    }

    return button;
  }

  /// Creates a text button with loading state support
  static Widget getTextButton({
    required BuildContext context,
    String? text,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    // Dimensions
    double? width,
    double? height,
    // Styling overrides
    Color? foregroundColor,
    // Typography
    TextStyle? textStyle,
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
  }) {
    assert(
      text != null || child != null,
      'Either text or child must be provided',
    );

    final isDisabled = disabled || onPressed == null || loading;
    final theme = Theme.of(context);
    final buttonStyle = theme.textButtonTheme.style;

    Widget button = SizedBox(
      width: width?.w,
      height: height?.h,
      child: TextButton(
        style: buttonStyle?.copyWith(
          foregroundColor: foregroundColor != null
              ? WidgetStateProperty.all(foregroundColor)
              : null,
        ),
        onPressed: isDisabled ? null : onPressed,
        onLongPress: isDisabled ? null : onLongPress,
        child: _buildButtonContent(
          context: context,
          loading: loading,
          text: text,
          child: child,
          icon: icon,
          textStyle: textStyle ?? buttonStyle?.textStyle?.resolve({}),
          loadingColor: loadingColor,
          loadingSize: loadingSize,
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

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
            loadingColor ?? Theme.of(context).colorScheme.onPrimary,
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
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textStyle,
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
}
