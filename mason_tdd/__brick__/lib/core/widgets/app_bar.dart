import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Lightweight config for quick actions in the custom app bar.
class AppBarAction {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  const AppBarAction({required this.icon, this.onPressed, this.tooltip});
}

/// Simple, theme-aware custom app bar widget
abstract class CustomAppBar {
  /// Creates an AppBar with enhanced features
  static PreferredSizeWidget getAppBar({
    required BuildContext context,
    // Core properties
    String? title,
    Widget? titleWidget,

    // Layout
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

    // Styling overrides
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    double? scrolledUnderElevation,
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

    Widget appBar = AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? appBarTheme.foregroundColor,
      shadowColor: shadowColor ?? appBarTheme.shadowColor,
      surfaceTintColor: surfaceTintColor ?? appBarTheme.surfaceTintColor,
      elevation: elevation ?? appBarTheme.elevation ?? 0.0,
      scrolledUnderElevation:
          scrolledUnderElevation ?? appBarTheme.scrolledUnderElevation ?? 0.0,
      toolbarHeight: toolbarHeight?.h ?? appBarTheme.toolbarHeight?.h,
      leadingWidth: leadingWidth?.w ?? appBarTheme.leadingWidth?.w,
      centerTitle: centerTitle ?? appBarTheme.centerTitle ?? true,
      titleSpacing: appBarTheme.titleSpacing ?? 0,
      shape: shape ?? appBarTheme.shape,
      systemOverlayStyle: systemOverlayStyle ?? appBarTheme.systemOverlayStyle,
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

    if (tooltip != null) {
      appBar = Tooltip(message: tooltip, child: appBar);
    }

    if (semanticLabel != null) {
      appBar = Semantics(label: semanticLabel, child: appBar);
    }

    final effectiveToolbarHeight =
        toolbarHeight?.h ?? appBarTheme.toolbarHeight?.h ?? 56.0.h;

    return PreferredSize(
      preferredSize: Size.fromHeight(
        effectiveToolbarHeight + (bottom?.preferredSize.height ?? 0),
      ),
      child: appBar,
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
    final iconTheme = appBarTheme.iconTheme ?? theme.iconTheme;

    final effectiveLeadingIconSize =
        leadingIconSize?.sp ?? iconTheme.size?.sp ?? 24.0.sp;
    final effectiveLeadingIconPadding =
        leadingIconPadding ?? const EdgeInsets.all(14.0);

    return Container(
      margin: EdgeInsets.only(left: 16.w),
      child: IconButton(
        padding: effectiveLeadingIconPadding,
        icon: _buildLeadingIcon(
          context,
          leadingIconAsset,
          leadingIcon,
          effectiveLeadingIconSize,
          iconTheme.color,
        ),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
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
        color: leadingIconColor,
        height: leadingIconSize,
        width: leadingIconSize,
      );
    }

    return Icon(
      leadingIcon ?? Icons.arrow_back_ios_new_rounded,
      color: leadingIconColor,
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

    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: titleTextStyle,
    );
  }

  static List<Widget>? _buildActions(
    BuildContext context,
    List<Widget>? actions,
    List<AppBarAction>? quickActions,
  ) {
    final allActions = <Widget>[];

    if (quickActions != null) {
      allActions.addAll(
        quickActions.map((action) => _buildQuickAction(context, action)),
      );
    }

    if (actions != null) {
      allActions.addAll(actions);
    }

    if (allActions.isEmpty) return null;

    return [...allActions, SizedBox(width: 16.w)];
  }

  static Widget _buildQuickAction(BuildContext context, AppBarAction action) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: IconButton(
        onPressed: action.onPressed,
        icon: action.icon,
        tooltip: action.tooltip,
      ),
    );
  }
}
