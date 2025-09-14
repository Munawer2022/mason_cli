import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Class for defining quick actions
class AppBarAction {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;

  const AppBarAction({
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.iconColor,
  });
}

/// Enhanced abstract class for CustomAppBar with improved functionality
abstract class CustomAppBar {
  // Default values
  static const double _defaultToolbarHeight = kToolbarHeight;
  static const double _defaultLeadingWidth = 80.0;
  static const double _defaultLeadingIconSize = 14.0;
  static const EdgeInsets _defaultLeadingIconPadding = EdgeInsets.all(14.0);
  static const double _defaultTitleFontSize = 24.0;
  static const double _defaultLeadingIconBorderRadius = 8.0;

  /// Creates an AppBar with enhanced features
  static PreferredSizeWidget getAppBar({
    required BuildContext context,
    // Core properties
    String? title,
    Widget? titleWidget,

    // Layout
    double? toolbarHeight,
    double? leadingWidth,
    bool centerTitle = true,
    bool automaticallyImplyLeading = false,
    EdgeInsets? titlePadding,
    EdgeInsets? actionsPadding,

    // Navigation
    bool showLeading = true,
    Widget? leading,
    VoidCallback? onLeadingPressed,
    String? leadingIconAsset,
    IconData? leadingIcon,

    // Actions
    List<Widget>? actions,
    List<AppBarAction>? quickActions,

    // Styling
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double elevation = 0.0,
    double scrolledUnderElevation = 0.0,
    ShapeBorder? shape,

    // Typography
    TextStyle? titleTextStyle,
    double? titleFontSize,
    FontWeight? titleFontWeight,

    // Leading icon styling
    double? leadingIconSize,
    EdgeInsets? leadingIconPadding,
    Color? leadingIconColor,
    Color? leadingIconBackgroundColor,
    double? leadingIconBorderRadius,

    // System UI
    SystemUiOverlayStyle? systemOverlayStyle,
    bool forceMaterialTransparency = false,

    // Bottom
    PreferredSizeWidget? bottom,

    // Accessibility
    String? tooltip,
    String? semanticLabel,

    // Animation
    Duration? animationDuration,
  }) {
    assert(
      title != null ||
          titleWidget != null ||
          actions != null ||
          quickActions != null,
      'AppBar must have at least title, titleWidget, or actions',
    );

    final effectiveToolbarHeight = toolbarHeight?.h ?? _defaultToolbarHeight.h;
    final effectiveLeadingWidth = leadingWidth?.w ?? _defaultLeadingWidth.w;

    Widget appBar = AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? _getDefaultBackgroundColor(context),
      foregroundColor: foregroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      toolbarHeight: effectiveToolbarHeight,
      leadingWidth: effectiveLeadingWidth,
      centerTitle: centerTitle,
      titleSpacing: 0,
      shape: shape,
      systemOverlayStyle:
          systemOverlayStyle ?? _getDefaultSystemOverlayStyle(context),
      forceMaterialTransparency: forceMaterialTransparency,
      leading: _buildLeading(
        context,
        showLeading,
        leading,
        onLeadingPressed,
        leadingIconAsset,
        leadingIcon,
        leadingIconSize,
        leadingIconPadding,
        leadingIconColor,
        leadingIconBackgroundColor,
        leadingIconBorderRadius,
      ),
      title: _buildTitle(
        context,
        title,
        titleWidget,
        titleTextStyle,
        titleFontSize,
        titleFontWeight,
      ),
      actions: _buildActions(context, actions, quickActions, actionsPadding),
      bottom: bottom,
    );

    // Add tooltip if provided
    if (tooltip != null) {
      appBar = Tooltip(message: tooltip, child: appBar);
    }

    // Add semantic label if provided
    if (semanticLabel != null) {
      appBar = Semantics(label: semanticLabel, child: appBar);
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(
        effectiveToolbarHeight + (bottom?.preferredSize.height ?? 0),
      ),
      child: appBar,
    );
  }

  // Helper methods
  static Color _getDefaultBackgroundColor(BuildContext context) {
    return context.theme.scaffoldBackgroundColor;
  }

  static SystemUiOverlayStyle _getDefaultSystemOverlayStyle(
    BuildContext context,
  ) {
    final isDark = context.theme.brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );
  }

  static Widget? _buildLeading(
    BuildContext context,
    bool showLeading,
    Widget? leading,
    VoidCallback? onLeadingPressed,
    String? leadingIconAsset,
    IconData? leadingIcon,
    double? leadingIconSize,
    EdgeInsets? leadingIconPadding,
    Color? leadingIconColor,
    Color? leadingIconBackgroundColor,
    double? leadingIconBorderRadius,
  ) {
    if (!showLeading) return null;
    if (leading != null) return leading;

    final effectiveLeadingIconSize =
        leadingIconSize?.sp ?? _defaultLeadingIconSize.sp;
    final effectiveLeadingIconPadding =
        leadingIconPadding ?? _defaultLeadingIconPadding;
    final effectiveLeadingIconBorderRadius =
        leadingIconBorderRadius?.r ?? _defaultLeadingIconBorderRadius.r;

    return Container(
      margin: EdgeInsets.only(left: 16.w),
      child: IconButton(
        padding: effectiveLeadingIconPadding,
        style: IconButton.styleFrom(
          backgroundColor:
              leadingIconBackgroundColor ??
              context.theme.iconButtonTheme.style?.backgroundColor?.resolve({}),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              effectiveLeadingIconBorderRadius,
            ),
          ),
        ),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
        icon: _buildLeadingIcon(
          context,
          leadingIconAsset,
          leadingIcon,
          effectiveLeadingIconSize,
          leadingIconColor,
        ),
      ),
    );
  }

  static Widget _buildLeadingIcon(
    BuildContext context,
    String? leadingIconAsset,
    IconData? leadingIcon,
    double leadingIconSize,
    Color? leadingIconColor,
  ) {
    if (leadingIconAsset != null) {
      return Image.asset(
        leadingIconAsset,
        color: leadingIconColor ?? context.theme.iconTheme.color,
        height: leadingIconSize,
        width: leadingIconSize,
      );
    }

    return Icon(
      leadingIcon ?? Icons.arrow_back_ios_new_rounded,
      color: leadingIconColor ?? context.theme.iconTheme.color,
      size: leadingIconSize,
    );
  }

  static Widget? _buildTitle(
    BuildContext context,
    String? title,
    Widget? titleWidget,
    TextStyle? titleTextStyle,
    double? titleFontSize,
    FontWeight? titleFontWeight,
  ) {
    if (titleWidget != null) return titleWidget;
    if (title == null) return null;

    final effectiveTitleFontSize =
        titleFontSize?.sp ?? _defaultTitleFontSize.sp;

    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: (titleTextStyle ?? context.textTheme.bodyLarge)?.copyWith(
        fontSize: effectiveTitleFontSize,
        fontWeight: titleFontWeight ?? FontWeight.w600,
      ),
    );
  }

  static List<Widget>? _buildActions(
    BuildContext context,
    List<Widget>? actions,
    List<AppBarAction>? quickActions,
    EdgeInsets? actionsPadding,
  ) {
    final allActions = <Widget>[];

    // Add quick actions
    if (quickActions != null) {
      allActions.addAll(
        quickActions.map((action) => _buildQuickAction(context, action)),
      );
    }

    // Add custom actions
    if (actions != null) {
      allActions.addAll(actions);
    }

    if (allActions.isEmpty) return null;

    return [
      ...allActions,
      SizedBox(width: 16.w), // Right padding
    ];
  }

  static Widget _buildQuickAction(BuildContext context, AppBarAction action) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: IconButton(
        onPressed: action.onPressed,
        icon: action.icon,
        tooltip: action.tooltip,
        style: IconButton.styleFrom(
          backgroundColor: action.backgroundColor,
          foregroundColor: action.iconColor,
        ),
      ),
    );
  }
}
