import 'package:flutter/cupertino.dart';

// models
import 'package:courier_rider/models/models.dart';

// service
import 'package:courier_rider/services/service.dart';

class AuthProvider extends ChangeNotifier {
  Authentication authService = Authentication();
  bool loading = false;
  String error = '';
  UserInfo? user;

  bool get isLoading => loading;
  String get errorMessage => error;

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
    error = '';
    notifyListeners();
  }

  // user register
  userRegister(UserRegister payload) async {
    try {
      setLoading(true);

      final response = await Authentication.registerUser(payload);
      final statusCode = response['statusCode'];

      if (statusCode == 201) {
        final userData = response['data']['user'];
        final tokenData = response['data']['token'];

        onSuccess();

        user = UserInfo(
            id: userData['_id'],
            name: userData['name'],
            email: userData['email'],
            phoneNumber: userData['phoneNumber'],
            role: userData['role'],
            createdOn: userData['createdOn'],
            token: tokenData);

        return user;
      } else {
        setError("User registration failure");
      }
    } catch (e) {
      print(e);
      setError("Error occured while user registration");
    }
    setLoading(false);
  }

  // user sign
  userSignIn(SignIn payload) async {
    try {
      setLoading(true);

      final response = await Authentication.signInUser(payload);
      final statusCode = response['statusCode'];

      if (statusCode == 200) {
        final userData = response['data']['user'];
        final tokenData = response['data']['token'];

        onSuccess();

        user = UserInfo(
            id: userData['_id'],
            name: userData['name'],
            email: userData['email'],
            phoneNumber: userData['phoneNumber'],
            role: userData['role'],
            createdOn: userData['createdOn'],
            token: tokenData);

        return user;
      } else {
        setError("Invalid email or password");
      }
    } catch (e) {
      setError("Error occured while signin");
    }
    setLoading(false);
  }
}
