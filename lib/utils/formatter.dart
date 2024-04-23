import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  static String formatDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String formatTime(TimeOfDay time) {
    return DateFormat('h:mm a')
        .format(DateTime(0, 0, 0, time.hour, time.minute));
  }
}
