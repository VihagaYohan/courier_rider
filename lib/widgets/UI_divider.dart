import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UIDivider extends StatelessWidget {
  final double height;
  final double? thickness;
  final Color? color;

  const UIDivider(
      {super.key, required this.height, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    final dividerColor = DeviceUtils.isDarkmode(context) == true
        ? AppColors.white
        : AppColors.darkGrey;

    return Divider(
        height: height, thickness: thickness, color: color ?? dividerColor);
  }
}
