import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Font & Color Helper/font_&_color_helper.dart';

class ShimmerHelper extends StatelessWidget {
  final Widget child;
  const ShimmerHelper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: hsPrime.withOpacity(0.8),
      period: const Duration(seconds: 1),
      highlightColor: hsPrime,
      child: child,
    );
  }
}