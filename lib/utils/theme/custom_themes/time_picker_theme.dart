import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class TTimePickerTheme {
  TTimePickerTheme();

  static TimePickerThemeData lightTimePickerTheme = const TimePickerThemeData(
    backgroundColor: AppColors.white,
    dialBackgroundColor: AppColors.white,
    dialHandColor: AppColors.primary,
    dialTextColor: AppColors.dark,
    hourMinuteTextColor: AppColors.darkGrey,
    hourMinuteColor: AppColors.white,
    dayPeriodTextColor: AppColors.dark,
    dayPeriodBorderSide: BorderSide(color: Colors.grey),
    dayPeriodColor: Colors.white,
    dayPeriodTextStyle: TextStyle(color: AppColors.dark),
    entryModeIconColor: AppColors.primary,
    helpTextStyle: TextStyle(color: AppColors.dark),
    cancelButtonStyle: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.white),
        foregroundColor: MaterialStatePropertyAll(AppColors.primary)),
    confirmButtonStyle: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.primary),
        foregroundColor: MaterialStatePropertyAll(AppColors.white)),
  );

  static TimePickerThemeData darkTimePickerTheme = TimePickerThemeData(
      backgroundColor: AppColors.dark,
      dialBackgroundColor: AppColors.primary.withOpacity(0.1),
      dialHandColor: AppColors.primary,
      dialTextColor: AppColors.white,
      hourMinuteTextColor: AppColors.white,
      hourMinuteColor: AppColors.dark,
      dayPeriodBorderSide: const BorderSide(color: Colors.grey),
      dayPeriodColor: AppColors.primary,
      dayPeriodTextStyle: const TextStyle(color: AppColors.white),
      dayPeriodTextColor: AppColors.white,
      entryModeIconColor: AppColors.primary,
      helpTextStyle: const TextStyle(color: AppColors.white),
      cancelButtonStyle: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppColors.dark),
          foregroundColor: MaterialStatePropertyAll(AppColors.primary)),
      confirmButtonStyle: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppColors.primary),
          foregroundColor: MaterialStatePropertyAll(AppColors.white)));
}
