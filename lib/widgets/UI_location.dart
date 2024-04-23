import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

class UILocation extends StatelessWidget {
  final String from;
  final String to;

  const UILocation({super.key, required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                  background: Colors.red,
                  secondary: AppColors.primary,
                ),
            canvasColor: DeviceUtils.isDarkmode(context) == true
                ? AppColors.dark
                : AppColors.white,
            shadowColor: Colors.transparent),
        child: Stepper(
          currentStep: 0,
          controlsBuilder: (context, details) => const SizedBox.shrink(),
          stepIconBuilder: (stepIndex, stepState) => SizedBox(
            width: 14,
            height: 14,
            child: Container(
              decoration: const BoxDecoration(color: AppColors.primary),
            ),
          ),
          steps: <Step>[
            // from
            Step(
                title: locationTitle(context, 'From'),
                content: Container(),
                subtitle: locationAddress(context, from),
                state: StepState.complete,
                isActive: true),
            // to
            Step(
                title: locationTitle(context, "To"),
                content: Container(),
                subtitle: locationAddress(context, to),
                state: StepState.complete,
                isActive: true),
          ],
        ));
  }

  // location title
  Widget locationTitle(BuildContext context, String title) {
    return UITextView(
      text: title,
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w300),
      textAlign: TextAlign.left,
    );
  }

  // location address
  Widget locationAddress(BuildContext context, String address) {
    return UITextView(
      text: address,
      textAlign: TextAlign.left,
      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
    );
  }
}
