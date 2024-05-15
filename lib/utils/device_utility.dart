import 'dart:io';

import 'package:courier_rider/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class DeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom < 0;
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isDarkmode(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }

  static Future<T?> showAlertDialog<T>(
    BuildContext context,
    title,
    content,
    buttonTitle,
    buttonPress,
    icon, {
    Color iconContainerColor = AppColors.primary,
    Color iconColor = AppColors.white,
    double iconSize = 25,
    bool showCancelButton = false,
    String cancelButtonTitle = "Cancel",
  }) async {
    return showDialog<T>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                isDarkmode(context) == true ? AppColors.dark : AppColors.white,
            icon: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: iconContainerColor),
              child: Icon(icon, size: iconSize, color: iconColor),
            ),
            title: UITextView(text: title),
            content: UITextView(text: content),
            actions: <Widget>[
              if (showCancelButton)
                UITextButton(
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  labelText: "Cancel",
                  textColor: AppColors.primary,
                  buttonColor: DeviceUtils.isDarkmode(context) == false
                      ? AppColors.white
                      : AppColors.dark,
                ),
              UITextButton(
                onPress: () {
                  Navigator.of(context).pop();
                  buttonPress();
                },
                labelText: buttonTitle,
                textColor: AppColors.white,
                buttonColor: AppColors.primary,
              )
            ],
          );
        });
  }

  static Future<DateTime?> getDatePicker(BuildContext context) async {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    final firstDate = DateTime(1990);
    final lastDate = DateTime(2050);
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        helpText: 'Select a package pick-up date',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: AppColors.primary, // header background color
                    onPrimary: AppColors.white,
                    onSurface: brightness == Brightness.dark
                        ? AppColors.white
                        : AppColors.textPrimary // header text color
                    ),
                dividerTheme: const DividerThemeData(color: AppColors.primary)),
            child: child!,
          );
        });
  }

  static Future<TimeOfDay?> getTimePicker(BuildContext context) async {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select a package pick-up time',
      builder: (BuildContext context, Widget? child) {
        return Theme(
            /* data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: AppColors.white,
                    onSurface: brightness == Brightness.dark
                        ? AppColors.darkerGrey
                        : AppColors.dark),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white))), */
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary,
                  onPrimary: AppColors.white,
                  /* onSurface: brightness == Brightness.dark
                        ? AppColors.warning
                        : AppColors.primary */
                ),
                textTheme: const TextTheme()),
            child: child!);

        /* return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ); */
      },
    );
    ;
  }

  static Future<T?> showBottomSheet<T>(
      BuildContext context, double height, Widget child) {
    return showModalBottomSheet<T>(
        context: context,
        showDragHandle: true,
        builder: (BuildContext context) {
          return Container(
            height: height,
            color:
                isDarkmode(context) == true ? AppColors.dark : AppColors.white,
            child: child,
          );
        });
  }
}
