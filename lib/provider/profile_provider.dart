import 'dart:convert';

import 'package:flutter/material.dart';

// models
import 'package:courier_rider/models/models.dart';

// service
import 'package:courier_rider/services/service.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class ProfileProvider extends ChangeNotifier {
  bool loading = false;
  String error = "";
  late UserInfo userInfo;

  bool get isLoading => loading;
  String get errorMessage => error;
  UserInfo get currentUser => userInfo;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setError(String value) {
    loading = false;
    error = value;
    notifyListeners();
  }

  void onSuccess() {
    loading = false;
    error = "";

    notifyListeners();
  }

  // get current user
  getCurrentUser() async {
    try {
      setLoading(true);
      final response = await Helper.getCurrentUser();
      if (jsonEncode(response).isNotEmpty) {
        onSuccess();
        userInfo = response;
      } else {
        setError("Unable to get current user data");
        return false;
      }
    } catch (e) {
      setError("Error occured while fetching current user");
    }
    setLoading(false);
  }
}
