import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UIStepper extends StatefulWidget {
  final List<Step> stepList;
  final int currentIndex;
  StepperType stepperType;

  UIStepper(
      {super.key,
      required this.stepList,
      required this.currentIndex,
      this.stepperType = StepperType.vertical});

  @override
  State<UIStepper> createState() => _UIStepperState();
}

class _UIStepperState extends State<UIStepper> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Theme(
      data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.green,
                background: Colors.red,
                secondary: Colors.blue,
              ),
          canvasColor: DeviceUtils.isDarkmode(context) == true
              ? AppColors.dark
              : AppColors.white,
          shadowColor: Colors.transparent),
      child: Stepper(
          type: widget.stepperType,
          elevation: 0,
          controlsBuilder: (context, controller) {
            return const SizedBox.shrink();
          },
          steps: widget.stepList),
    ));
  }
}
