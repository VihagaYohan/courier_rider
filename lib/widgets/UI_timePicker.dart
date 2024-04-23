import 'package:courier_rider/widgets/widgets.dart';
import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UITimePicker extends StatefulWidget {
  final TextEditingController controll;
  final String labelText;
  final Function onTap;
  final FormFieldValidator<String>? validator;
  final bool? showIcon;
  final Icon? suffixIcon;
  final Color? suffixIconColor;
  TimeOfDay? pickedTime = TimeOfDay.now();

  UITimePicker(
      {super.key,
      required this.controll,
      required this.labelText,
      required this.onTap,
      this.validator,
      this.showIcon = false,
      this.suffixIcon,
      this.suffixIconColor});

  @override
  State<UITimePicker> createState() => _UITimePickerState();
}

class _UITimePickerState extends State<UITimePicker> {
  @override
  Widget build(BuildContext context) {
    Future<void> getDate() async {
      dynamic picked = DeviceUtils.getDatePicker(context);
      print(picked);
    }

    return GestureDetector(
      onTap: () {
        widget.onTap();
        DeviceUtils.getTimePicker(context).then((value) => {
              setState(() {
                widget.pickedTime = value!;
                widget.controll.text = AppFormatter.formatTime(
                    widget.pickedTime!); // widget.pickedTime.toString();
              })
            });
      },
      child: UITextField(
        controller: widget.controll,
        labelText: widget.labelText,
        readOnly: true,
        enabaled: false,
        validator: widget.validator,
        showSuffixIcon: widget.showIcon,
        suffixIcon: widget.showIcon == true ? widget.suffixIcon : null,
        suffixIconColor:
            widget.showIcon == true ? widget.suffixIconColor : AppColors.dark,
      ),
    );
  }
}
