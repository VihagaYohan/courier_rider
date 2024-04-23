import 'package:courier_rider/utils/colors.dart';
import 'package:courier_rider/utils/device_utility.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UITextButton extends StatelessWidget {
  final VoidCallback onPress;
  final String labelText;
  final Color textColor;
  final Color buttonColor;

  const UITextButton(
      {super.key,
      required this.onPress,
      required this.labelText,
      this.buttonColor = AppColors.white,
      this.textColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPress();
      },
      style: TextButton.styleFrom(
          foregroundColor: textColor, backgroundColor: buttonColor),
      child: UITextView(
        text: labelText,
        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: textColor, fontWeight: FontWeight.w400, fontSize: 12),
      ),
    );
  }
}
