import 'package:courier_rider/widgets/widgets.dart';
import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';
import 'package:intl/intl.dart';

class UIDatePicker extends StatefulWidget {
  final TextEditingController controll;
  final String labelText;
  final Function onTap;
  final FormFieldValidator<String>? validator;
  final bool? showIcon;
  final Icon? suffixIcon;
  final Color? suffixIconColor;
  DateTime? picked = DateTime.now();

  UIDatePicker({
    super.key,
    required this.controll,
    required this.labelText,
    required this.onTap,
    this.validator,
    this.showIcon = false,
    this.suffixIcon,
    this.suffixIconColor,
  });

  @override
  State<UIDatePicker> createState() => _UIDatePickerState();
}

class _UIDatePickerState extends State<UIDatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        DeviceUtils.getDatePicker(context).then((value) {
          setState(() {
            widget.picked = value!;
            widget.controll.text = AppFormatter.formatDate(widget.picked!);
          });
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
