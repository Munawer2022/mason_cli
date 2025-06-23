import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/core/utils/extensions.dart';

Shimmer shimmer(
  BuildContext context, {
  Color? baseColor,
  required Widget child,
}) => Shimmer.fromColors(
  period: const Duration(milliseconds: 300),
  baseColor: baseColor ?? context.theme.cardColor,
  highlightColor: context.theme.cardColor.withOpacity(0.7),
  direction: ShimmerDirection.btt,
  child: child,
);
