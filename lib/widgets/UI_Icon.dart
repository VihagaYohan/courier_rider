import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UIIcon extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final double? size;

  const UIIcon(
      {super.key,
      required this.iconData,
      this.iconColor = AppColors.primary,
      this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, color: iconColor, size: size);
  }
}
