import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Simple, theme‑aware custom button to keep buttons consistent & reusable.
abstract class AppButton {
  static const double _defaultHeight = 48.0;
  static const double _defaultBorderWidth = 1.0;

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

    final theme = Theme.of(context);
    final buttonTheme = theme.elevatedButtonTheme;
    final buttonStyle = buttonTheme.style;

    final bool isDisabled = disabled || onPressed == null;
    final effectiveHeight = height?.h ?? _defaultHeight.h;

    // Extract radius from theme
    double effectiveRadius = 8.0;
    if (radius != null) {
      effectiveRadius = radius;
    } else if (buttonStyle?.shape != null) {
      final shape = buttonStyle!.shape?.resolve({});
      if (shape is RoundedRectangleBorder) {
        final borderRadius = shape.borderRadius.resolve(
          Directionality.of(context),
        );
        effectiveRadius = borderRadius.topLeft.x;
      }
    }
    effectiveRadius = effectiveRadius.r;

    // Extract padding from theme
    EdgeInsets? effectivePadding = padding;
    if (effectivePadding == null && buttonStyle?.padding != null) {
      final paddingProp = buttonStyle!.padding?.resolve({});
      if (paddingProp is EdgeInsets) {
        effectivePadding = paddingProp;
      }
    }
    effectivePadding ??= const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    );

    // Extract colors from theme
    final themeBgColor =
        buttonStyle?.backgroundColor?.resolve({}) ?? theme.colorScheme.primary;
    final themeFgColor =
        buttonStyle?.foregroundColor?.resolve({}) ??
        theme.colorScheme.onPrimary;
    final themeElevation =
        elevation ?? buttonStyle?.elevation?.resolve({}) ?? 2.0;

    Widget button = Container(
      width: width?.w ?? double.infinity,
      height: effectiveHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveRadius),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: themeElevation,
          backgroundColor: _getBackgroundColor(
            context,
            backgroundColor,
            disabledBackgroundColor,
            isDisabled,
            themeBgColor,
          ),
          foregroundColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
            themeFgColor,
          ),
          disabledBackgroundColor:
              disabledBackgroundColor ??
              theme.colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor:
              disabledTextColor ??
              theme.colorScheme.onSurface.withOpacity(0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
          ),
          padding: effectivePadding,
          minimumSize: Size(double.infinity, effectiveHeight),
          animationDuration:
              animationDuration ??
              buttonStyle?.animationDuration ??
              const Duration(milliseconds: 200),
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
          defaultTextStyle: buttonStyle?.textStyle?.resolve({}),
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
            themeFgColor,
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

    final theme = Theme.of(context);
    final buttonTheme = theme.outlinedButtonTheme;
    final buttonStyle = buttonTheme.style;

    final bool isDisabled = disabled || onPressed == null;
    final effectiveHeight = height?.h ?? _defaultHeight.h;

    // Extract radius from theme
    double effectiveRadius = 8.0;
    if (radius != null) {
      effectiveRadius = radius;
    } else if (buttonStyle?.shape != null) {
      final shape = buttonStyle!.shape?.resolve({});
      if (shape is RoundedRectangleBorder) {
        final borderRadius = shape.borderRadius.resolve(
          Directionality.of(context),
        );
        effectiveRadius = borderRadius.topLeft.x;
      }
    }
    effectiveRadius = effectiveRadius.r;

    // Extract padding from theme
    EdgeInsets? effectivePadding = padding;
    if (effectivePadding == null && buttonStyle?.padding != null) {
      final paddingProp = buttonStyle!.padding?.resolve({});
      if (paddingProp is EdgeInsets) {
        effectivePadding = paddingProp;
      }
    }
    effectivePadding ??= const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    );

    final effectiveBorderWidth = borderWidth?.w ?? _defaultBorderWidth.w;

    // Extract colors from theme
    final themeBgColor =
        buttonStyle?.backgroundColor?.resolve({}) ?? Colors.transparent;
    final themeFgColor =
        buttonStyle?.foregroundColor?.resolve({}) ?? theme.colorScheme.primary;
    final themeBorderColor =
        buttonStyle?.side?.resolve({})?.color ?? theme.colorScheme.primary;

    Widget button = SizedBox(
      width: width?.w ?? double.infinity,
      height: effectiveHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? themeBgColor,
          foregroundColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
            themeFgColor,
          ),
          disabledForegroundColor:
              disabledTextColor ??
              theme.colorScheme.onSurface.withOpacity(0.38),
          side: BorderSide(
            color: _getBorderColor(
              context,
              borderColor,
              disabledBorderColor,
              isDisabled,
              themeBorderColor,
            ),
            width: effectiveBorderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
          ),
          padding: effectivePadding,
          minimumSize: Size(double.infinity, effectiveHeight),
          animationDuration:
              animationDuration ??
              buttonStyle?.animationDuration ??
              const Duration(milliseconds: 200),
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
          defaultTextStyle: buttonStyle?.textStyle?.resolve({}),
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
            themeFgColor,
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

  /// Creates a text button with enhanced features
  static Widget getTextButton({
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
    Color? disabledTextColor,
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

    final theme = Theme.of(context);
    final buttonTheme = theme.textButtonTheme;
    final buttonStyle = buttonTheme.style;

    final bool isDisabled = disabled || onPressed == null;
    final effectiveHeight = height?.h ?? _defaultHeight.h;

    // Extract padding from theme
    EdgeInsets? effectivePadding = padding;
    if (effectivePadding == null && buttonStyle?.padding != null) {
      final paddingProp = buttonStyle!.padding?.resolve({});
      if (paddingProp is EdgeInsets) {
        effectivePadding = paddingProp;
      }
    }
    effectivePadding ??= const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    );

    // Extract color from theme
    final themeFgColor =
        buttonStyle?.foregroundColor?.resolve({}) ?? theme.colorScheme.primary;

    Widget button = SizedBox(
      width: width?.w,
      height: effectiveHeight,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
            themeFgColor,
          ),
          textStyle: buttonStyle?.textStyle?.resolve({}),
          disabledForegroundColor:
              disabledTextColor ??
              theme.colorScheme.onSurface.withOpacity(0.38),
          padding: effectivePadding,
          minimumSize: Size(width?.w ?? 0, effectiveHeight),
          animationDuration:
              animationDuration ??
              buttonStyle?.animationDuration ??
              const Duration(milliseconds: 200),
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
          defaultTextStyle: buttonStyle?.textStyle?.resolve({}),
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: _getTextColor(
            context,
            textColor,
            disabledTextColor,
            isDisabled,
            themeFgColor,
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
    TextStyle? defaultTextStyle,
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
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: _buildTextStyle(
            context,
            textStyle,
            defaultTextStyle,
            fontSize,
            fontWeight,
            textColor,
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
    TextStyle? defaultTextStyle,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
  ) {
    final baseStyle =
        textStyle ?? defaultTextStyle ?? context.textTheme.titleSmall;

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
    Color? themeBackgroundColor,
  ) {
    if (isDisabled) {
      return disabledBackgroundColor ??
          context.theme.colorScheme.onSurface.withOpacity(0.12);
    }
    return backgroundColor ??
        themeBackgroundColor ??
        context.theme.colorScheme.primary;
  }

  /// Gets the text color based on state
  static Color _getTextColor(
    BuildContext context,
    Color? textColor,
    Color? disabledTextColor,
    bool isDisabled,
    Color? themeTextColor,
  ) {
    if (isDisabled) {
      return disabledTextColor ??
          context.theme.colorScheme.onSurface.withOpacity(0.38);
    }
    return textColor ?? themeTextColor ?? context.theme.colorScheme.onPrimary;
  }

  /// Gets the border color based on state
  static Color _getBorderColor(
    BuildContext context,
    Color? borderColor,
    Color? disabledBorderColor,
    bool isDisabled,
    Color? themeBorderColor,
  ) {
    if (isDisabled) {
      return disabledBorderColor ??
          context.theme.colorScheme.onSurface.withOpacity(0.12);
    }
    return borderColor ?? themeBorderColor ?? context.theme.colorScheme.primary;
  }
}
