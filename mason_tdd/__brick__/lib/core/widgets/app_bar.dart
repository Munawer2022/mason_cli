import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Configuration class for AppBar styling and behavior
class AppBarConfig {
  // Layout
  final double toolbarHeight;
  final double leadingWidth;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final EdgeInsets titlePadding;
  final EdgeInsets actionsPadding;

  // Styling
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double elevation;
  final double scrolledUnderElevation;
  final ShapeBorder? shape;

  // Typography
  final TextStyle? titleTextStyle;
  final double titleFontSize;
  final FontWeight titleFontWeight;

  // Leading icon
  final double leadingIconSize;
  final EdgeInsets leadingIconPadding;
  final Color? leadingIconColor;
  final Color? leadingIconBackgroundColor;
  final double leadingIconBorderRadius;

  // System UI
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool forceMaterialTransparency;

  const AppBarConfig({
    // Layout defaults
    this.toolbarHeight = kToolbarHeight,
    this.leadingWidth = 80.0,
    this.centerTitle = true,
    this.automaticallyImplyLeading = false,
    this.titlePadding = EdgeInsets.zero,
    this.actionsPadding = const EdgeInsets.symmetric(horizontal: 8.0),

    // Styling defaults
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation = 0.0,
    this.scrolledUnderElevation = 0.0,
    this.shape,

    // Typography defaults
    this.titleTextStyle,
    this.titleFontSize = 24.0,
    this.titleFontWeight = FontWeight.w600,

    // Leading icon defaults
    this.leadingIconSize = 14.0,
    this.leadingIconPadding = const EdgeInsets.all(14.0),
    this.leadingIconColor,
    this.leadingIconBackgroundColor,
    this.leadingIconBorderRadius = 8.0,

    // System UI
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
  });

  AppBarConfig copyWith({
    double? toolbarHeight,
    double? leadingWidth,
    bool? centerTitle,
    bool? automaticallyImplyLeading,
    EdgeInsets? titlePadding,
    EdgeInsets? actionsPadding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    double? scrolledUnderElevation,
    ShapeBorder? shape,
    TextStyle? titleTextStyle,
    double? titleFontSize,
    FontWeight? titleFontWeight,
    double? leadingIconSize,
    EdgeInsets? leadingIconPadding,
    Color? leadingIconColor,
    Color? leadingIconBackgroundColor,
    double? leadingIconBorderRadius,
    SystemUiOverlayStyle? systemOverlayStyle,
    bool? forceMaterialTransparency,
  }) {
    return AppBarConfig(
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      centerTitle: centerTitle ?? this.centerTitle,
      automaticallyImplyLeading:
          automaticallyImplyLeading ?? this.automaticallyImplyLeading,
      titlePadding: titlePadding ?? this.titlePadding,
      actionsPadding: actionsPadding ?? this.actionsPadding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      elevation: elevation ?? this.elevation,
      scrolledUnderElevation:
          scrolledUnderElevation ?? this.scrolledUnderElevation,
      shape: shape ?? this.shape,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleFontWeight: titleFontWeight ?? this.titleFontWeight,
      leadingIconSize: leadingIconSize ?? this.leadingIconSize,
      leadingIconPadding: leadingIconPadding ?? this.leadingIconPadding,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      leadingIconBackgroundColor:
          leadingIconBackgroundColor ?? this.leadingIconBackgroundColor,
      leadingIconBorderRadius:
          leadingIconBorderRadius ?? this.leadingIconBorderRadius,
      systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
      forceMaterialTransparency:
          forceMaterialTransparency ?? this.forceMaterialTransparency,
    );
  }
}

/// Enum for different AppBar variants
enum AppBarType {
  standard,
  search,
  tabbed,
  profile,
  settings,
  transparent,
  colored,
}

/// Main CustomAppBar widget with improved architecture
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Core properties
  final String? title;
  final Widget? titleWidget;
  final AppBarType type;
  final AppBarConfig? config;

  // Navigation
  final bool showLeading;
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final String? leadingIconAsset;
  final IconData? leadingIcon;

  // Actions
  final List<Widget>? actions;
  final List<AppBarAction>? quickActions;

  // Bottom
  final PreferredSizeWidget? bottom;

  // Behavior
  final bool pinned;
  final bool floating;
  final bool snap;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.type = AppBarType.standard,
    this.config,
    this.showLeading = true,
    this.leading,
    this.onLeadingPressed,
    this.leadingIconAsset,
    this.leadingIcon,
    this.actions,
    this.quickActions,
    this.bottom,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveConfig = config ?? _getDefaultConfig(context);

    return AppBar(
      automaticallyImplyLeading: effectiveConfig.automaticallyImplyLeading,
      backgroundColor:
          effectiveConfig.backgroundColor ?? _getBackgroundColor(context, type),
      foregroundColor: effectiveConfig.foregroundColor,
      shadowColor: effectiveConfig.shadowColor,
      surfaceTintColor: effectiveConfig.surfaceTintColor,
      elevation: effectiveConfig.elevation,
      scrolledUnderElevation: effectiveConfig.scrolledUnderElevation,
      toolbarHeight: effectiveConfig.toolbarHeight.h,
      leadingWidth: effectiveConfig.leadingWidth.w,
      centerTitle: effectiveConfig.centerTitle,
      titleSpacing: 0,
      shape: effectiveConfig.shape,
      systemOverlayStyle:
          effectiveConfig.systemOverlayStyle ??
          _getSystemOverlayStyle(context, type),
      forceMaterialTransparency: effectiveConfig.forceMaterialTransparency,
      leading: _buildLeading(context, effectiveConfig),
      title: _buildTitle(context, effectiveConfig),
      actions: _buildActions(context, effectiveConfig),
      bottom: bottom,
    );
  }

  AppBarConfig _getDefaultConfig(BuildContext context) {
    return AppBarConfig(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      titleTextStyle: context.textTheme.bodyLarge,
    );
  }

  Color? _getBackgroundColor(BuildContext context, AppBarType type) {
    switch (type) {
      case AppBarType.transparent:
        return Colors.transparent;
      case AppBarType.colored:
        return context.theme.primaryColor;
      default:
        return context.theme.scaffoldBackgroundColor;
    }
  }

  SystemUiOverlayStyle? _getSystemOverlayStyle(
    BuildContext context,
    AppBarType type,
  ) {
    final isDark = context.theme.brightness == Brightness.dark;

    switch (type) {
      case AppBarType.transparent:
        return SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        );
      case AppBarType.colored:
        return const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        );
      default:
        return SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        );
    }
  }

  Widget? _buildLeading(BuildContext context, AppBarConfig config) {
    if (!showLeading) return null;
    if (leading != null) return leading;

    return Container(
      margin: EdgeInsets.only(left: 16.w),
      child: IconButton(
        padding: config.leadingIconPadding,
        style: IconButton.styleFrom(
          backgroundColor:
              config.leadingIconBackgroundColor ??
              context.theme.iconButtonTheme.style?.backgroundColor?.resolve({}),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              config.leadingIconBorderRadius.r,
            ),
          ),
        ),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
        icon: _buildLeadingIcon(context, config),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context, AppBarConfig config) {
    if (leadingIconAsset != null) {
      return Image.asset(
        leadingIconAsset!,
        color: config.leadingIconColor ?? context.theme.iconTheme.color,
        height: config.leadingIconSize.h,
        width: config.leadingIconSize.w,
      );
    }

    return Icon(
      leadingIcon ?? Icons.arrow_back_ios_new_rounded,
      color: config.leadingIconColor ?? context.theme.iconTheme.color,
      size: config.leadingIconSize.sp,
    );
  }

  Widget? _buildTitle(BuildContext context, AppBarConfig config) {
    if (titleWidget != null) return titleWidget;
    if (title == null) return null;

    return Text(
      title!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: (config.titleTextStyle ?? context.textTheme.bodyLarge)?.copyWith(
        fontSize: config.titleFontSize.sp,
        fontWeight: config.titleFontWeight,
      ),
    );
  }

  List<Widget>? _buildActions(BuildContext context, AppBarConfig config) {
    final allActions = <Widget>[];

    // Add quick actions
    if (quickActions != null) {
      allActions.addAll(
        quickActions!.map((action) => _buildQuickAction(context, action)),
      );
    }

    // Add custom actions
    if (actions != null) {
      allActions.addAll(actions!);
    }

    if (allActions.isEmpty) return null;

    return [
      ...allActions,
      SizedBox(width: 16.w), // Right padding
    ];
  }

  Widget _buildQuickAction(BuildContext context, AppBarAction action) {
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

  @override
  Size get preferredSize => Size.fromHeight(
    (config?.toolbarHeight ?? kToolbarHeight).h +
        (bottom?.preferredSize.height ?? 0),
  );
}

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

/// Specialized AppBar widgets for common use cases
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final AppBarConfig? config;
  final bool showLeading;
  final List<Widget>? actions;

  const SearchAppBar({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.config,
    this.showLeading = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      type: AppBarType.search,
      config: config,
      showLeading: showLeading,
      titleWidget: _buildSearchField(context),
      actions: actions,
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.hintColor,
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller?.text.isNotEmpty == true
              ? IconButton(
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                  },
                  icon: const Icon(Icons.clear),
                  iconSize: 20.sp,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((config?.toolbarHeight ?? kToolbarHeight).h);
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final String? userSubtitle;
  final Widget? avatar;
  final List<AppBarAction>? actions;
  final AppBarConfig? config;

  const ProfileAppBar({
    super.key,
    this.userName,
    this.userSubtitle,
    this.avatar,
    this.actions,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      type: AppBarType.profile,
      config: config?.copyWith(centerTitle: false),
      showLeading: false,
      titleWidget: _buildProfileTitle(context),
      quickActions: actions,
    );
  }

  Widget _buildProfileTitle(BuildContext context) {
    return Row(
      children: [
        if (avatar != null) ...[avatar!, 16.horizontalSpace],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (userName != null)
                Text(
                  userName!,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (userSubtitle != null)
                Text(
                  userSubtitle!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.theme.hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((config?.toolbarHeight ?? kToolbarHeight).h);
}

/// Extension for easier usage
extension AppBarExtensions on BuildContext {
  AppBarConfig get defaultAppBarConfig => AppBarConfig(
    backgroundColor: theme.scaffoldBackgroundColor,
    titleTextStyle: textTheme.bodyLarge,
    leadingIconColor: theme.iconTheme.color,
  );

  PreferredSizeWidget simpleAppBar(
    String title, {
    List<Widget>? actions,
    bool showLeading = true,
  }) {
    return CustomAppBar(
      title: title,
      showLeading: showLeading,
      actions: actions,
      config: defaultAppBarConfig,
    );
  }
}
