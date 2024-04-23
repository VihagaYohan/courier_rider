import 'package:flutter/material.dart';

// constants
import 'package:courier_rider/utils/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); // private constructor

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primary,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.green.shade600,
          backgroundColor: AppColors.primary,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
}
