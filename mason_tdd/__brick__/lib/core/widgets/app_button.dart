import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Configuration class for AppButton styling and behavior
class AppButtonConfig {
  // Size and layout
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsets padding;
  final Size? minimumSize;
  final Size? maximumSize;
  final Size? fixedSize;

  // Styling
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;

  // Border
  final BorderSide? side;
  final Color? borderColor;
  final double borderWidth;

  // Typography
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;

  // Loading
  final Color? loadingIndicatorColor;
  final double loadingIndicatorSize;
  final double loadingIndicatorStrokeWidth;

  // Animation
  final Duration animationDuration;
  final Curve animationCurve;

  // Interaction
  final MaterialTapTargetSize? tapTargetSize;
  final VisualDensity? visualDensity;
  final bool enableFeedback;

  const AppButtonConfig({
    // Size and layout
    this.width,
    this.height = 50.0,
    this.borderRadius = 100.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,

    // Styling
    this.elevation = 0.0,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.shadowColor,
    this.surfaceTintColor,

    // Border
    this.side,
    this.borderColor,
    this.borderWidth = 1.0,

    // Typography
    this.textStyle,
    this.fontSize,
    this.fontWeight,

    // Loading
    this.loadingIndicatorColor,
    this.loadingIndicatorSize = 20.0,
    this.loadingIndicatorStrokeWidth = 2.0,

    // Animation
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,

    // Interaction
    this.tapTargetSize,
    this.visualDensity,
    this.enableFeedback = true,
  });

  AppButtonConfig copyWith({
    double? width,
    double? height,
    double? borderRadius,
    EdgeInsets? padding,
    Size? minimumSize,
    Size? maximumSize,
    Size? fixedSize,
    double? elevation,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    BorderSide? side,
    Color? borderColor,
    double? borderWidth,
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? fontWeight,
    Color? loadingIndicatorColor,
    double? loadingIndicatorSize,
    double? loadingIndicatorStrokeWidth,
    Duration? animationDuration,
    Curve? animationCurve,
    MaterialTapTargetSize? tapTargetSize,
    VisualDensity? visualDensity,
    bool? enableFeedback,
  }) {
    return AppButtonConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      minimumSize: minimumSize ?? this.minimumSize,
      maximumSize: maximumSize ?? this.maximumSize,
      fixedSize: fixedSize ?? this.fixedSize,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledForegroundColor:
          disabledForegroundColor ?? this.disabledForegroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      side: side ?? this.side,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      textStyle: textStyle ?? this.textStyle,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      loadingIndicatorColor:
          loadingIndicatorColor ?? this.loadingIndicatorColor,
      loadingIndicatorSize: loadingIndicatorSize ?? this.loadingIndicatorSize,
      loadingIndicatorStrokeWidth:
          loadingIndicatorStrokeWidth ?? this.loadingIndicatorStrokeWidth,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      tapTargetSize: tapTargetSize ?? this.tapTargetSize,
      visualDensity: visualDensity ?? this.visualDensity,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }
}

/// Enum for different button variants
enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  icon,
  fab,
  gradient,
  destructive,
  success,
  warning,
}

/// Enum for button sizes
enum AppButtonSize {
  small(
    height: 36.0,
    fontSize: 14.0,
    padding: EdgeInsets.symmetric(horizontal: 12.0),
  ),
  medium(
    height: 44.0,
    fontSize: 16.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
  ),
  large(
    height: 52.0,
    fontSize: 18.0,
    padding: EdgeInsets.symmetric(horizontal: 20.0),
  ),
  extraLarge(
    height: 60.0,
    fontSize: 20.0,
    padding: EdgeInsets.symmetric(horizontal: 24.0),
  );

  const AppButtonSize({
    required this.height,
    required this.fontSize,
    required this.padding,
  });

  final double height;
  final double fontSize;
  final EdgeInsets padding;
}

/// Main AppButton widget with improved architecture
class AppButton extends StatefulWidget {
  // Core properties
  final String? text;
  final Widget? child;
  final Widget? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  // Variant and configuration
  final AppButtonVariant variant;
  final AppButtonSize size;
  final AppButtonConfig? config;

  // State
  final bool loading;
  final bool disabled;

  // Styling
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;

  // Accessibility
  final String? tooltip;
  final String? semanticLabel;

  const AppButton({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.onLongPress,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.config,
    this.loading = false,
    this.disabled = false,
    this.gradient,
    this.boxShadow,
    this.tooltip,
    this.semanticLabel,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveConfig = _getEffectiveConfig(context);
    final isDisabled =
        widget.disabled || widget.onPressed == null || widget.loading;

    Widget button = _buildButton(context, effectiveConfig, isDisabled);

    // Add gradient if specified
    if (widget.gradient != null &&
        widget.variant != AppButtonVariant.outlined) {
      button = _wrapWithGradient(button, effectiveConfig);
    }

    // Add tooltip if specified
    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    // Add scale animation
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: button);
      },
    );
  }

  AppButtonConfig _getEffectiveConfig(BuildContext context) {
    final baseConfig = _getBaseConfigForVariant(context);
    final sizeConfig = _getConfigForSize();

    return baseConfig.copyWith(
      width: widget.config?.width ?? sizeConfig.width,
      height: widget.config?.height ?? sizeConfig.height,
      fontSize: widget.config?.fontSize ?? sizeConfig.fontSize,
      padding: widget.config?.padding ?? sizeConfig.padding,
    );
  }

  AppButtonConfig _getBaseConfigForVariant(BuildContext context) {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppButtonConfig(
          backgroundColor: context.theme.colorScheme.primary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          disabledBackgroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.12),
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      case AppButtonVariant.secondary:
        return AppButtonConfig(
          backgroundColor: context.theme.colorScheme.secondary,
          foregroundColor: context.theme.colorScheme.onSecondary,
          disabledBackgroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.12),
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      case AppButtonVariant.outlined:
        return AppButtonConfig(
          backgroundColor: Colors.transparent,
          foregroundColor: context.theme.colorScheme.primary,
          borderColor: context.theme.colorScheme.primary,
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      case AppButtonVariant.text:
        return AppButtonConfig(
          backgroundColor: Colors.transparent,
          foregroundColor: context.theme.colorScheme.primary,
          elevation: 0,
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      case AppButtonVariant.destructive:
        return AppButtonConfig(
          backgroundColor: context.theme.colorScheme.error,
          foregroundColor: context.theme.colorScheme.onError,
          disabledBackgroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.12),
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      case AppButtonVariant.success:
        return AppButtonConfig(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          disabledBackgroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.12),
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      case AppButtonVariant.warning:
        return AppButtonConfig(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          disabledBackgroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.12),
          disabledForegroundColor: context.theme.colorScheme.onSurface
              .withOpacity(0.38),
        );
      default:
        return widget.config ?? AppButtonConfig();
    }
  }

  AppButtonConfig _getConfigForSize() {
    return AppButtonConfig(
      height: widget.size.height,
      fontSize: widget.size.fontSize,
      padding: widget.size.padding,
    );
  }

  Widget _buildButton(
    BuildContext context,
    AppButtonConfig config,
    bool isDisabled,
  ) {
    final buttonStyle = _buildButtonStyle(context, config, isDisabled);
    final child = _buildChild(context, config);

    return SizedBox(
      width: config.width?.w ?? double.infinity,
      height: config.height?.h ?? 0,
      child: _getButtonWidget(buttonStyle, child, isDisabled),
    );
  }

  Widget _getButtonWidget(ButtonStyle style, Widget child, bool isDisabled) {
    switch (widget.variant) {
      case AppButtonVariant.outlined:
        return OutlinedButton(
          style: style,
          onPressed: isDisabled ? null : _handlePress,
          onLongPress: widget.onLongPress,
          child: child,
        );
      case AppButtonVariant.text:
        return TextButton(
          style: style,
          onPressed: isDisabled ? null : _handlePress,
          onLongPress: widget.onLongPress,
          child: child,
        );
      case AppButtonVariant.fab:
        return FloatingActionButton(
          onPressed: isDisabled ? null : _handlePress,
          backgroundColor: style.backgroundColor?.resolve({}),
          foregroundColor: style.foregroundColor?.resolve({}),
          elevation: style.elevation?.resolve({}) ?? 6,
          child: child,
        );
      default:
        return ElevatedButton(
          style: style,
          onPressed: isDisabled ? null : _handlePress,
          onLongPress: widget.onLongPress,
          child: child,
        );
    }
  }

  ButtonStyle _buildButtonStyle(
    BuildContext context,
    AppButtonConfig config,
    bool isDisabled,
  ) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return config.disabledBackgroundColor;
        }
        return config.backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return config.disabledForegroundColor;
        }
        return config.foregroundColor;
      }),
      elevation: WidgetStateProperty.all(config.elevation),
      shadowColor: WidgetStateProperty.all(config.shadowColor),
      surfaceTintColor: WidgetStateProperty.all(config.surfaceTintColor),
      side: widget.variant == AppButtonVariant.outlined
          ? WidgetStateProperty.resolveWith((states) {
              final color = states.contains(WidgetState.disabled)
                  ? context.theme.colorScheme.onSurface.withOpacity(0.12)
                  : config.borderColor;
              return BorderSide(color: color!, width: config.borderWidth.w);
            })
          : null,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.borderRadius.r),
        ),
      ),
      padding: WidgetStateProperty.all(config.padding),
      minimumSize: WidgetStateProperty.all(
        config.minimumSize ?? Size(double.infinity, config.height?.h ?? 0),
      ),
      maximumSize: WidgetStateProperty.all(config.maximumSize),
      fixedSize: WidgetStateProperty.all(config.fixedSize),
      textStyle: WidgetStateProperty.all(
        (config.textStyle ?? context.textTheme.titleSmall)?.copyWith(
          fontSize: config.fontSize?.sp,
          fontWeight: config.fontWeight,
        ),
      ),
      tapTargetSize: config.tapTargetSize,
      visualDensity: config.visualDensity,
      enableFeedback: config.enableFeedback,
      animationDuration: config.animationDuration,
    );
  }

  Widget _buildChild(BuildContext context, AppButtonConfig config) {
    if (widget.loading) {
      return SizedBox(
        width: config.loadingIndicatorSize.w,
        height: config.loadingIndicatorSize.h,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: config.loadingIndicatorStrokeWidth,
          valueColor: AlwaysStoppedAnimation(
            config.loadingIndicatorColor ?? config.foregroundColor,
          ),
        ),
      );
    }

    if (widget.child != null) return widget.child!;

    final List<Widget> children = [];

    if (widget.icon != null) {
      children.add(widget.icon!);
      if (widget.text != null) {
        children.add(SizedBox(width: 8.w));
      }
    }

    if (widget.text != null) {
      children.add(
        Flexible(
          child: Text(
            widget.text!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return children.length == 1
        ? children.first
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
  }

  Widget _wrapWithGradient(Widget button, AppButtonConfig config) {
    return Container(
      width: config.width?.w ?? double.infinity,
      height: config.height?.h,
      decoration: BoxDecoration(
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(config.borderRadius.r),
        boxShadow: widget.boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.loading || widget.disabled || widget.onPressed == null
              ? null
              : _handlePress,
          onLongPress: widget.onLongPress,
          borderRadius: BorderRadius.circular(config.borderRadius.r),
          child: Container(
            alignment: Alignment.center,
            child: _buildChild(context, config),
          ),
        ),
      ),
    );
  }

  void _handlePress() {
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
    widget.onPressed?.call();
  }
}

/// Specialized button widgets for common use cases
class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final AppButtonSize size;
  final Widget? icon;
  final AppButtonConfig? config;

  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.size = AppButtonSize.medium,
    this.icon,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      loading: loading,
      size: size,
      icon: icon,
      variant: AppButtonVariant.primary,
      config: config,
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final AppButtonSize size;
  final Widget? icon;
  final AppButtonConfig? config;

  const AppOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.size = AppButtonSize.medium,
    this.icon,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      loading: loading,
      size: size,
      icon: icon,
      variant: AppButtonVariant.outlined,
      config: config,
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonSize size;
  final Widget? icon;
  final AppButtonConfig? config;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      size: size,
      icon: icon,
      variant: AppButtonVariant.text,
      config: config,
    );
  }
}

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final AppButtonConfig? config;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.config,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      icon: icon,
      onPressed: onPressed,
      variant: variant,
      size: size,
      config: config?.copyWith(width: size.height, padding: EdgeInsets.zero),
      tooltip: tooltip,
    );
  }
}

/// Extension for easier usage
extension AppButtonExtensions on BuildContext {
  AppButtonConfig get defaultButtonConfig => AppButtonConfig(
    backgroundColor: theme.colorScheme.primary,
    foregroundColor: theme.colorScheme.onPrimary,
    textStyle: textTheme.titleSmall,
  );
}
