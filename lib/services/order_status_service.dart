import 'dart:convert';

import 'package:http/http.dart' as http;

// models
import 'package:courier_rider/models/models.dart';

// endpoint
import 'package:courier_rider/services/endpoints.dart';

class OrderStatusService {
  // fetch all types of courier statuses
  static getAllOrderStatus() async {
    try {
      List<OrderStatus> orderStatusTypes = [];
      final response = await http.get(Uri.parse(Endpoints.courierTypes));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var eachItem in jsonData['data']) {
          final orderStatus =
              OrderStatus(id: eachItem['_id'], name: eachItem['name']);
          orderStatusTypes.add(orderStatus);
        }
        return orderStatusTypes;
      } else {
        throw Exception("Failed to load order status");
      }
    } catch (e) {
      throw Exception("Unable to fetch order status $e");
    }
  }
}
