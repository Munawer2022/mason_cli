import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer shimmer({Color? baseColor, required Widget child}) =>
    Shimmer.fromColors(
      period: const Duration(milliseconds: 300),
      baseColor: baseColor ?? Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
