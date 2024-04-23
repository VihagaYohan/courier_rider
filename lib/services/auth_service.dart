import 'dart:convert';

import 'package:courier_rider/services/endpoints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// constants
import 'package:courier_rider/utils/utils.dart';

// models
import 'package:courier_rider/models/models.dart';

class Authentication {
  static registerUser(UserRegister payload) async {
    try {
      final response = await http.post(Uri.parse(Endpoints.register),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(payload));
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception("User registration failed");
      }
    } catch (e) {
      throw Exception("Error occured at registering user $e");
    }
  }

  static signInUser(SignIn payload) async {
    try {
      final response = await http.post(Uri.parse(Endpoints.login),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(<String, dynamic>{
            "email": payload.email,
            "password": payload.password
          }));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      print("Error at login user $e");
    }
  }
}
