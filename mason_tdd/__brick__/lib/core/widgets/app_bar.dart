import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Lightweight config for quick actions in the custom app bar.
class AppBarAction {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  const AppBarAction({required this.icon, this.onPressed, this.tooltip});
}

/// Simple, theme‑aware custom app bar to keep app bars consistent & reusable.
abstract class CustomAppBar {
  /// Creates an AppBar with enhanced features
  static PreferredSizeWidget getAppBar({
    required BuildContext context,
    // Core properties
    String? title,
    Widget? titleWidget,

    // Layout (kept intentionally small – most things come from theme)
    double? toolbarHeight,
    double? leadingWidth,
    bool? centerTitle,
    bool automaticallyImplyLeading = false,

    // Navigation
    bool showLeading = true,
    Widget? leading,
    VoidCallback? onLeadingPressed,
    String? leadingIconAsset,
    IconData? leadingIcon,

    // Actions
    List<AppBarAction>? quickActions,
    List<Widget>? actions,

    // Styling
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    double scrolledUnderElevation = 0.0,
    ShapeBorder? shape,

    // Typography
    TextStyle? titleTextStyle,

    // Leading icon styling
    double? leadingIconSize,
    EdgeInsets? leadingIconPadding,

    // System UI
    SystemUiOverlayStyle? systemOverlayStyle,
    bool forceMaterialTransparency = false,

    // Bottom widget (e.g. TabBar)
    PreferredSizeWidget? bottom,

    // Accessibility
    String? tooltip,
    String? semanticLabel,
  }) {
    assert(
      title != null ||
          titleWidget != null ||
          actions != null ||
          quickActions != null,
      'AppBar must have at least title, titleWidget, or actions',
    );

    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;

    final effectiveToolbarHeight =
        (toolbarHeight ?? appBarTheme.toolbarHeight ?? kToolbarHeight).h;
    final effectiveLeadingWidth =
        (leadingWidth ?? appBarTheme.leadingWidth ?? 80.0).w;

    Widget appBar = AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor:
          backgroundColor ??
          appBarTheme.backgroundColor ??
          _getDefaultBackgroundColor(context),
      foregroundColor: foregroundColor ?? appBarTheme.foregroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation ?? appBarTheme.elevation ?? 0.0,
      scrolledUnderElevation: scrolledUnderElevation,
      toolbarHeight: effectiveToolbarHeight,
      leadingWidth: effectiveLeadingWidth,
      centerTitle: centerTitle ?? appBarTheme.centerTitle ?? true,
      titleSpacing: 0,
      shape: shape ?? appBarTheme.shape,
      systemOverlayStyle:
          systemOverlayStyle ??
          appBarTheme.systemOverlayStyle ??
          _getDefaultSystemOverlayStyle(context),
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
      ),
      title: _buildTitle(
        context,
        title,
        titleWidget,
        titleTextStyle ?? appBarTheme.titleTextStyle,
      ),
      actions: _buildActions(context, actions, quickActions),
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
    final theme = context.theme;
    return theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface;
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
  ) {
    if (!showLeading) return null;
    if (leading != null) return leading;

    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;
    final effectiveLeadingIconSize =
        leadingIconSize?.sp ?? (appBarTheme.iconTheme?.size ?? 20.0).sp;
    final effectiveLeadingIconPadding =
        leadingIconPadding ?? const EdgeInsets.all(14.0);

    return Container(
      margin: EdgeInsets.only(left: 16.w),
      child: IconButton(
        padding: effectiveLeadingIconPadding,
        style: IconButton.styleFrom(
          backgroundColor: context.theme.iconButtonTheme.style?.backgroundColor
              ?.resolve({}),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              appBarTheme.shape is RoundedRectangleBorder
                  ? (appBarTheme.shape as RoundedRectangleBorder).borderRadius
                        .resolve(Directionality.of(context))
                        .topLeft
                        .x
                  : 8.0,
            ),
          ),
        ),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
        icon: _buildLeadingIcon(
          context,
          leadingIconAsset,
          leadingIcon,
          effectiveLeadingIconSize,
          appBarTheme.iconTheme?.color ?? context.theme.iconTheme.color,
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
  ) {
    if (titleWidget != null) return titleWidget;
    if (title == null) return null;
    final theme = Theme.of(context);

    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: titleTextStyle ?? theme.appBarTheme.titleTextStyle,
    );
  }

  static List<Widget>? _buildActions(
    BuildContext context,
    List<Widget>? actions,
    List<AppBarAction>? quickActions,
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
        style: IconButton.styleFrom(),
      ),
    );
  }
}
