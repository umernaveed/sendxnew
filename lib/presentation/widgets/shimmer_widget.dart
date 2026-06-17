import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.color,
    this.shape = BoxShape.rectangle,
    this.radius,
    this.margin,
    this.padding,
  });
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final BoxShape shape;
  final BorderRadiusGeometry? radius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      direction: ShimmerDirection.ltr,
      // highlightColor: Colors.green,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          shape: shape,
          borderRadius: radius,
        ),
        child: child,
      ),
    );
  }
}
