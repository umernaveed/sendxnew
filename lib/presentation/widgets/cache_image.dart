import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final bool circular;
  final Color placeholderColor;
  final Widget errorWidget;
  final Widget placeHolder;

  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.circular = false,
    this.placeholderColor = Colors.transparent,
    this.errorWidget = const Center(
      child: Icon(
        Icons.error,
        size: 48,
        color: Colors.red,
      ),
    ),
    this.placeHolder = const Center(
      child: CircularProgressIndicator(),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: circular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: circular ? null : BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => placeHolder,
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
