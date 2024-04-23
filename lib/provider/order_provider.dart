// models
import 'dart:convert';
import 'package:flutter/material.dart';

// models
import 'package:courier_rider/models/models.dart';

// services
import 'package:courier_rider/services/service.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class OrderProvider extends ChangeNotifier {
  bool loading = false;
  String error = "";
  OrderRequest? order;
  List<OrderResponse> orders = [];

  bool get isLoading => loading;
  String get errorMessage => error;
  List<OrderResponse> get orderList => orders;

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

  // create order
  createOrder(OrderRequest payload) async {
    try {
      setLoading(true);
      final response = await OrderService.createOrder(payload);
      if (response == 200) {
        onSuccess();
        return true;
      } else {
        setError("Unable to create courier order");
        return false;
      }
    } catch (e) {
      setError("Error occured while creating the order");
    }
    setLoading(false);
  }

  // get list of orders
  getAllOrders() async {
    try {
      setLoading(true);
      List<OrderResponse> response = await OrderService.getListOfOrders();
      if (response.isNotEmpty) {
        onSuccess();
        orders = response;
      } else {
        setError('There are no orders to show');
      }
    } catch (e) {
      print(e);
      setError("Error occured\nPlease try again");
    }
    setLoading(false);
  }
}
