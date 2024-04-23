// models
import 'package:courier_rider/models/UserInfo.dart';

class SignInResponse {
  final bool success;
  final String message;
  final int statusCode;
  final UserInfo data;
  final String token;

  SignInResponse(
      {required this.success,
      required this.message,
      required this.statusCode,
      required this.data,
      required this.token});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
        success: json['success'],
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'],
        token: json['token']);
  }
}
