import 'package:courier_rider/utils/colors.dart';
import 'package:courier_rider/utils/utils.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/constants.dart';
import 'package:flutter/widgets.dart';

class UITextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final bool? obsecureText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final bool? showIcon;
  final Widget? icon;
  final Color? iconColor;
  final bool? showSuffixIcon;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final dynamic? borderColor;
  final bool readOnly;
  final bool enabaled;
  final int? maxLines;
  final bool expands;

  const UITextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.obsecureText = false,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.validator,
    this.showIcon = false,
    this.icon,
    this.iconColor = AppColors.primary,
    this.showSuffixIcon = false,
    this.suffixIcon,
    this.suffixIconColor = AppColors.primary,
    this.borderColor = AppColors.grey,
    this.readOnly = false,
    this.enabaled = true,
    this.maxLines = 1,
    this.expands = false,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      showCursor: true,
      cursorColor: AppColors.primary,
      cursorWidth: 1,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w300,
            ),
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 16),
        prefixIcon: showIcon == true ? icon : null,
        prefixIconColor: iconColor,
        suffixIcon: showSuffixIcon == true ? this.suffixIcon : null,
        suffixIconColor: this.suffixIconColor,
        enabledBorder: const OutlineInputBorder()
            .copyWith(borderSide: BorderSide(color: borderColor)),
        contentPadding: const EdgeInsets.all(8),
      ),
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      textAlign: TextAlign.left,
      readOnly: readOnly,
      enabled: enabaled,
      maxLines: maxLines,
      expands: expands,
    );
  }
}
