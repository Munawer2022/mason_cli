import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '/core/utils/extensions.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;
  final bool showMessage;
  final LoadingType type;

  const LoadingWidget({
    super.key,
    this.message,
    this.size,
    this.color,
    this.showMessage = true,
    this.type = LoadingType.circular,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLoadingIndicator(context),
          if (showMessage && message != null) ...[
            16.verticalSpace,
            Text(
              message!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final effectiveColor = color ?? context.theme.colorScheme.primary;
    final effectiveSize = size ?? 24.w;

    switch (type) {
      case LoadingType.circular:
        return SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          ),
        );
      case LoadingType.adaptive:
        return SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2.w,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          ),
        );
      case LoadingType.linear:
        return SizedBox(
          width: 200.w,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            backgroundColor: effectiveColor.withOpacity(0.2),
          ),
        );
      case LoadingType.dots:
        return _DotsLoadingWidget(color: effectiveColor, size: effectiveSize);
      case LoadingType.pulse:
        return _PulseLoadingWidget(color: effectiveColor, size: effectiveSize);
    }
  }
}

class _DotsLoadingWidget extends StatefulWidget {
  final Color color;
  final double size;

  const _DotsLoadingWidget({required this.color, required this.size});

  @override
  State<_DotsLoadingWidget> createState() => _DotsLoadingWidgetState();
}

class _DotsLoadingWidgetState extends State<_DotsLoadingWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: Duration(milliseconds: 600 + (index * 200)),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    for (var controller in _controllers) {
      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: widget.size * 0.3,
              height: widget.size * 0.3,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(_animations[index].value),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}

class _PulseLoadingWidget extends StatefulWidget {
  final Color color;
  final double size;

  const _PulseLoadingWidget({required this.color, required this.size});

  @override
  State<_PulseLoadingWidget> createState() => _PulseLoadingWidgetState();
}

class _PulseLoadingWidgetState extends State<_PulseLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.3 + (_animation.value * 0.7)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

enum LoadingType { circular, adaptive, linear, dots, pulse }

// Shimmer Loading Widget
class ShimmerLoadingWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoadingWidget({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? context.theme.cardColor,
      highlightColor:
          highlightColor ?? context.theme.cardColor.withOpacity(0.7),
      period: const Duration(milliseconds: 1500),
      child: child,
    );
  }
}

// Skeleton Loading Widget
class SkeletonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsets? margin;

  const SkeletonWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
    );
  }
}

// List Skeleton Loading Widget
class ListSkeletonWidget extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;
  final EdgeInsets? padding;

  const ListSkeletonWidget({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? EdgeInsets.all(16.w),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing.h),
      itemBuilder: (context, index) {
        return ShimmerLoadingWidget(
          child: SkeletonWidget(
            width: double.infinity,
            height: itemHeight.h,
            borderRadius: 12,
          ),
        );
      },
    );
  }
}
