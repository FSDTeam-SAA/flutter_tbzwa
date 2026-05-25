import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  /// Path to the SVG asset (required)
  final String asset;

  /// Optional width and height
  final double? width;
  final double? height;

  /// Optional color tint for the SVG
  final Color? color;

  const AppSvg({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (asset.isEmpty) return SizedBox(width: width, height: height);

    if (asset.toLowerCase().endsWith('.png') ||
        asset.toLowerCase().endsWith('.jpg') ||
        asset.toLowerCase().endsWith('.jpeg')) {
      return Image.asset(
        asset,
        width: width,
        height: height,
        color: color,
        fit: BoxFit.contain,
      );
    }

    return SvgPicture.asset(
      asset,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: BoxFit.contain,
    );
  }
}
