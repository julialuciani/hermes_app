import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? height;
  final double? width;

  const SvgIcon({
    Key? key,
    required this.asset,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
      width: width ?? 50,
      height: height ?? 50,
    );
  }
}
