import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Assuming your extensions file has theme extension
// import '/core/utils/extensions.dart';

/// A comprehensive shimmer utility for consistent loading placeholders
class AppShimmer {
  // Private constructor to prevent instantiation
  AppShimmer._();

  /// Default shimmer duration
  static const Duration _defaultDuration = Duration(milliseconds: 1200);

  /// Default shimmer direction
  static const ShimmerDirection _defaultDirection = ShimmerDirection.ltr;

  /// Creates a shimmer effect wrapping [child] with customizable properties
  static Widget shimmer(
    BuildContext context, {
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
    ShimmerDirection direction = _defaultDirection,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      period: duration,
      baseColor: baseColor ?? _getBaseColor(theme, isDark),
      highlightColor: highlightColor ?? _getHighlightColor(theme, isDark),
      direction: direction,
      child: child,
    );
  }

  /// Creates a shimmer container with specified dimensions
  static Widget container(
    BuildContext context, {
    double? width,
    double? height,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
    ShimmerDirection direction = _defaultDirection,
  }) {
    return shimmer(
      context,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      direction: direction,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
        ),
      ),
    );
  }

  /// Creates a circular shimmer placeholder (useful for avatars)
  static Widget circle(
    BuildContext context, {
    required double radius,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
  }) {
    return shimmer(
      context,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      child: CircleAvatar(radius: radius, backgroundColor: Colors.white),
    );
  }

  /// Creates multiple shimmer text lines (useful for paragraph loading)
  static Widget text(
    BuildContext context, {
    int lines = 3,
    double height = 16,
    double? width,
    double spacing = 8,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
    List<double>? lineWidths, // Custom width for each line
  }) {
    return shimmer(
      context,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(lines, (index) {
          final lineWidth = lineWidths != null && index < lineWidths.length
              ? lineWidths[index]
              : (width ?? double.infinity) * (index == lines - 1 ? 0.7 : 1.0);

          return Padding(
            padding: EdgeInsets.only(bottom: index < lines - 1 ? spacing : 0),
            child: Container(
              width: lineWidth,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius ?? BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Creates a shimmer card layout
  static Widget card(
    BuildContext context, {
    double? width,
    double height = 200,
    EdgeInsets padding = const EdgeInsets.all(16),
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
    bool showAvatar = true,
    bool showTitle = true,
    bool showSubtitle = true,
    bool showContent = true,
  }) {
    return shimmer(
      context,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showAvatar || showTitle || showSubtitle)
              Row(
                children: [
                  if (showAvatar) ...[
                    CircleAvatar(radius: 20, backgroundColor: Colors.grey[300]),
                    const SizedBox(width: 12),
                  ],
                  if (showTitle || showSubtitle)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showTitle)
                            Container(
                              width: double.infinity,
                              height: 16,
                              color: Colors.grey[300],
                            ),
                          if (showTitle && showSubtitle)
                            const SizedBox(height: 4),
                          if (showSubtitle)
                            Container(
                              width: 150,
                              height: 12,
                              color: Colors.grey[300],
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            if ((showAvatar || showTitle || showSubtitle) && showContent)
              const SizedBox(height: 16),
            if (showContent)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Container(width: 200, height: 12, color: Colors.grey[300]),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Creates a list tile shimmer
  static Widget listTile(
    BuildContext context, {
    bool showLeading = true,
    bool showTrailing = false,
    double leadingRadius = 24,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
  }) {
    return shimmer(
      context,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      child: ListTile(
        leading: showLeading
            ? CircleAvatar(radius: leadingRadius, backgroundColor: Colors.white)
            : null,
        title: Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 4),
          height: 12,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        trailing: showTrailing
            ? Container(
                width: 60,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            : null,
      ),
    );
  }

  /// Creates a shimmer grid for loading grid layouts
  static Widget grid(
    BuildContext context, {
    required int itemCount,
    required int crossAxisCount,
    double aspectRatio = 1.0,
    double crossAxisSpacing = 8,
    double mainAxisSpacing = 8,
    EdgeInsets padding = EdgeInsets.zero,
    BorderRadius? itemBorderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
  }) {
    return Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return shimmer(
            context,
            baseColor: baseColor,
            highlightColor: highlightColor,
            duration: duration,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: itemBorderRadius ?? BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Creates a button shimmer placeholder
  static Widget button(
    BuildContext context, {
    double width = 120,
    double height = 40,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = _defaultDuration,
  }) {
    return shimmer(
      context,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
      ),
    );
  }

  /// Get appropriate base color for current theme
  static Color _getBaseColor(ThemeData theme, bool isDark) {
    if (isDark) {
      return Colors.grey[800]!.withOpacity(0.6);
    } else {
      return Colors.grey[300]!.withOpacity(0.6);
    }
  }

  /// Get appropriate highlight color for current theme
  static Color _getHighlightColor(ThemeData theme, bool isDark) {
    if (isDark) {
      return Colors.grey[700]!.withOpacity(0.3);
    } else {
      return Colors.grey[100]!.withOpacity(0.3);
    }
  }

  /// Creates a custom shimmer with predefined animation curves
  static Widget customAnimation(
    BuildContext context, {
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = Curves.easeInOut,
    Color? baseColor,
    Color? highlightColor,
    required TickerProvider vsync,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: AnimationController.unbounded(vsync: vsync)
        ..repeat(min: 0.0, max: 1.0, period: duration),
      builder: (context, _) {
        return shimmer(
          context,
          baseColor: baseColor,
          highlightColor: highlightColor,
          duration: duration,
          child: child,
        );
      },
    );
  }
}
