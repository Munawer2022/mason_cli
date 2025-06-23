import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/constants/global.dart';

/// An animated text widget for SnackBars
class AnimatedSnackBarContent extends StatefulWidget {
  final String message;

  const AnimatedSnackBarContent({super.key, required this.message});

  @override
  State<AnimatedSnackBarContent> createState() =>
      _AnimatedSnackBarContentState();
}

class _AnimatedSnackBarContentState extends State<AnimatedSnackBarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text(
          widget.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

mixin ShowSnackBarSuccess {
  void showSuccessSnackBar(String message) {
    var snackBar = SnackBar(
      content: AnimatedSnackBarContent(message: message),
      backgroundColor: Colors.grey.shade800,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 20.0.h),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.white,
        onPressed: () => GlobalConstants.scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(),
      ),
    );

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

mixin ShowSnackBarError {
  void showErrorSnackBar(String message) {
    var snackBar = SnackBar(
      content: AnimatedSnackBarContent(message: message),
      backgroundColor: Colors.grey.shade800,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 20.0.h),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.white,
        onPressed: () => GlobalConstants.scaffoldMessengerKey.currentState!
            .hideCurrentSnackBar(),
      ),
    );

    GlobalConstants.scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
