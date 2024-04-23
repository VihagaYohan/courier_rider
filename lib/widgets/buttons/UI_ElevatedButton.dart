import 'package:courier_rider/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/colors.dart';

class UIElevatedButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final double? width;
  final bool? showSuffixIcon;
  final Widget? suffixIcon;
  final bool? isPrimary;

  const UIElevatedButton(
      {super.key,
      required this.label,
      required this.onPress,
      this.width = double.infinity,
      this.showSuffixIcon = false,
      this.suffixIcon,
      this.isPrimary = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            onPress();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isPrimary == true ? AppColors.primary : AppColors.dark,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showSuffixIcon == true ? suffixIcon! : const SizedBox.shrink(),
              const SizedBox(
                width: 10,
              ),
              UITextView(
                text: label,
                textStyle: TextStyle(
                    color: isPrimary == false
                        ? AppColors.primary
                        : AppColors.textWhite),
              )
            ],
          ),
        ));
  }
}
