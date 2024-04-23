import 'package:courier_rider/utils/colors.dart';
import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class TTextFieldTheme {
  TTextFieldTheme();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1, color: AppColors.darkGrey // AppColors.primary
            )),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide:
            const BorderSide(width: 1, color: AppColors.grey //AppColors.primary
                )),
    disabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 1, color: AppColors.grey)),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide:
          const BorderSide(width: 1, color: AppColors.grey //AppColors.primary
              ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 2, color: Colors.orange)),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 2,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
      hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle:
          const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
              width: 1, color: AppColors.grey // AppColors.primary
              )),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
              width: 1, color: AppColors.grey //AppColors.primary
              )),
      disabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 1, color: AppColors.grey)),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
              width: 1, color: AppColors.grey // AppColors.primary
              )),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 2, color: Colors.orange)));
}
