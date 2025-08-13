import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool showShadow;
  final CardType type;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.showShadow = true,
    this.type = CardType.elevated,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveElevation = elevation ?? _getDefaultElevation();
    final effectiveBorderRadius = borderRadius ?? 12.r;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.cardColor;
    final effectiveBorderColor =
        borderColor ?? context.theme.colorScheme.outline.withOpacity(0.2);

    Widget cardContent = Container(
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: borderWidth != null
            ? Border.all(color: effectiveBorderColor, width: borderWidth!)
            : null,
        boxShadow: showShadow && type == CardType.elevated
            ? [
                BoxShadow(
                  color: context.theme.shadowColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: cardContent,
      );
    }

    if (margin != null) {
      cardContent = Container(margin: margin, child: cardContent);
    }

    return cardContent;
  }

  double _getDefaultElevation() {
    switch (type) {
      case CardType.elevated:
        return 2;
      case CardType.outlined:
        return 0;
      case CardType.flat:
        return 0;
    }
  }
}

enum CardType { elevated, outlined, flat }

// Specialized Card Widgets
class InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final EdgeInsets? margin;

  const InfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: margin,
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: (iconColor ?? context.theme.colorScheme.primary)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: iconColor ?? context.theme.colorScheme.primary,
                size: 24.sp,
              ),
            ),
            16.horizontalSpace,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  4.verticalSpace,
                  Text(
                    subtitle!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.onSurface.withOpacity(
                        0.7,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onTap != null) ...[
            Icon(
              Icons.chevron_right,
              color: context.theme.colorScheme.onSurface.withOpacity(0.5),
              size: 20.sp,
            ),
          ],
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? accentColor;
  final EdgeInsets? margin;

  const ActionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.accentColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveAccentColor =
        accentColor ?? context.theme.colorScheme.primary;

    return AppCard(
      onTap: onTap,
      margin: margin,
      type: CardType.outlined,
      borderColor: effectiveAccentColor.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: effectiveAccentColor, size: 24.sp),
                12.horizontalSpace,
              ],
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: effectiveAccentColor,
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            8.verticalSpace,
            Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final bool isPositive;
  final EdgeInsets? margin;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.isPositive = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.theme.colorScheme.primary;

    return AppCard(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: effectiveColor, size: 20.sp),
                8.horizontalSpace,
              ],
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: effectiveColor,
            ),
          ),
          if (subtitle != null) ...[
            4.verticalSpace,
            Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 16.sp,
                ),
                4.horizontalSpace,
                Text(
                  subtitle!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String? email;
  final String? avatarUrl;
  final VoidCallback? onTap;
  final EdgeInsets? margin;

  const ProfileCard({
    super.key,
    required this.name,
    this.email,
    this.avatarUrl,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: margin,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : null,
            child: avatarUrl == null
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (email != null) ...[
                  4.verticalSpace,
                  Text(
                    email!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.onSurface.withOpacity(
                        0.7,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onTap != null) ...[
            Icon(
              Icons.edit_outlined,
              color: context.theme.colorScheme.onSurface.withOpacity(0.5),
              size: 20.sp,
            ),
          ],
        ],
      ),
    );
  }
}
