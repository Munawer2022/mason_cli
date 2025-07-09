import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? memCacheWidth;
  final double? memCacheHeight;
  final double? maxWidthDiskCache;
  final double? maxHeightDiskCache;
  final Duration? fadeInDuration;
  final Duration? fadeOutDuration;
  final bool useOldImageOnUrlChange;
  final bool cacheManager;
  final bool showUserInitials;
  final String? userName;
  final Color? primaryColor;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.backgroundColor,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.fadeInDuration,
    this.fadeOutDuration,
    this.useOldImageOnUrlChange = false,
    this.cacheManager = true,
    this.showUserInitials = false,
    this.userName,
    this.primaryColor,
  });

  String _getUserInitial(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    return name.trim().substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePrimaryColor = primaryColor ?? theme.colorScheme.primary;

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        memCacheWidth: memCacheWidth?.toInt(),
        memCacheHeight: memCacheHeight?.toInt(),
        maxWidthDiskCache: maxWidthDiskCache?.toInt(),
        maxHeightDiskCache: maxHeightDiskCache?.toInt(),
        fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 300),
        fadeOutDuration: fadeOutDuration ?? const Duration(milliseconds: 300),
        useOldImageOnUrlChange: useOldImageOnUrlChange,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>
            placeholder ??
            Container(
              color: backgroundColor ?? Colors.grey[200],
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      effectivePrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            (showUserInitials
                ? Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: effectivePrimaryColor.withOpacity(0.2),
                      borderRadius: borderRadius ?? BorderRadius.zero,
                    ),
                    child: Center(
                      child: Text(
                        _getUserInitial(userName),
                        style: TextStyle(
                          color: effectivePrimaryColor,
                          fontSize: (width != null ? width! / 2 : 24).sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: backgroundColor ?? Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey[400],
                        size: 24.w,
                      ),
                    ),
                  )),
      ),
    );
  }
}
