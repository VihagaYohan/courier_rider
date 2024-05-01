import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

// model
import 'package:courier_rider/models/models.dart';

// endpoints
import 'package:courier_rider/services/endpoints.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class OrderService {
  // create new courier order
  static createOrder(OrderRequest payload) async {
    try {
      final response = await http.post(Uri.parse(Endpoints.order),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(payload.toJson()));
      return response.statusCode;
    } catch (e) {
      throw Exception('Error at creating new order $e');
    }
  }

  // get list of orders
  static getListOfOrders() async {
    try {
      final token = await Helper.getToken();
      final userId = await Helper.getUserId();

      List<OrderResponse> orders = [];
      final response = await http.get(
          Uri.parse(Endpoints(id: userId).orderList),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authorization': token
          });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var items = jsonData['data'];

        for (var item in items) {
          final orderItem = OrderResponse(
              id: item['_id'],
              trackingId: item['trackingId'],
              status: Status.fromJson(item['status']),
              courierType: CourierType.fromJson(item['courierType']),
              packageType: PackageType.fromJson(item['packageType']),
              packageSize: item['packageSize'],
              senderDetails:
                  SenderDetailsResponse.fromJson(item['senderDetails']),
              receiverDetails:
                  ReceiverDetailsResponse.fromJson(item['receiverDetails']),
              orderTotal: item['orderTotal'].toDouble(),
              paymentType: PaymentTypes.fromJson(item['paymentType']),
              createdOn: item['createdOn'],
              rider: Rider.fromJson(item['rider']));
          orders.add(orderItem);
        }
        return orders;
      } else {
        throw Exception("Failed to fetch all orders");
      }
    } catch (e) {
      throw Exception("Error at fetching orders $e");
    }
  }

  // update order
  static updateExistingOrderStatus(OrderResponse payload) async {
    try {
      final token = await Helper.getToken();
      final response = await http.put(Uri.parse(Endpoints.updateOrderStatus),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authorization': token
          },
          body: jsonEncode(payload.toJson()));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Unable to update order $e');
    }
  }
}
