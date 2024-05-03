import 'package:courier_rider/utils/utils.dart';

enum Environment { development, production }

class Endpoints {
  static Environment currentEnvionment = Environment.development;
  final String? id;

  Endpoints({this.id});

  static void setEnvironment(Environment env) {
    currentEnvionment = env;
  }

  static String get baseUrl {
    switch (currentEnvionment) {
      case Environment.production:
        return Constants.production_URL;
      case Environment.development:
        return Constants.development_URL;
      default:
        return Constants.development_URL;
    }
  }

  // static properties for endpoints
  static String get login => '${baseUrl}/auth/login';
  static String get register => '${baseUrl}/auth/register';
  static String get courierTypes => '$baseUrl/courierTypes';
  String get courierTypeById => '$baseUrl/courierTypes/$id';
  static String get packageTypes => '$baseUrl/packageTypes';
  String get packageTypeById => '$baseUrl/packageTypes/$id';
  static String get paymentTypes => '$baseUrl/paymentTypes';
  static String get orderStatus => '$baseUrl/courierStates';
  static String get order => '$baseUrl/orders';
  String get orderList => '$baseUrl/orders/user/$id/rider';
  String get updateOrderStatus => '$baseUrl/orders/status/$id';
}
