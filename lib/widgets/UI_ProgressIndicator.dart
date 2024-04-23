import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UIProgressIndicator extends StatelessWidget {
  final String? title;

  const UIProgressIndicator({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    print(title);
    return Container(
      decoration: BoxDecoration(
          color: DeviceUtils.isDarkmode(context) == true
              ? AppColors.dark
              : AppColors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              strokeCap: StrokeCap.round,
            ),
            const UISpacer(
              space: Constants.smallSpace,
            ),
            if (title != null)
              UITextView(
                text: title!,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: DeviceUtils.isDarkmode(context) == true
                        ? AppColors.white
                        : AppColors.textPrimary),
              )
          ],
        ),
      ),
    );
  }
}
