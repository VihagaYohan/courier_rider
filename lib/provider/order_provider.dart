// models
import 'dart:convert';
import 'package:courier_rider/models/OrderResponse.dart';
import 'package:courier_rider/services/helper_service.dart';
import 'package:flutter/material.dart';

// models
import 'package:courier_rider/models/models.dart';

// services
import 'package:courier_rider/services/service.dart';

// utils
import 'package:courier_rider/utils/utils.dart';
import 'package:get/get.dart';

class OrderProvider extends ChangeNotifier {
  bool loading = false;
  String error = "";
  OrderRequest? order;
  List<OrderResponse> orders = [];
  List<CourierStatus> courierStatus = [];
  OrderResponse? currentOrder;

  bool get isLoading => loading;
  String get errorMessage => error;
  List<OrderResponse> get orderList => orders;
  List<CourierStatus> get statusList => courierStatus;
  OrderResponse? get getCurentOrder => currentOrder;

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
        setLoading(true);
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
      setError("Error occured\nPlease try again");
    }
    setLoading(false);
  }

  // get all courier order status types
  getCourierStatusTypes() async {
    try {
      setLoading(true);
      List<CourierStatus> response = await HelperService.getAllCourierStatus();
      if (response.isNotEmpty) {
        onSuccess();
        courierStatus = response;
      } else {
        setError("There are no courier status to show");
      }
    } catch (e) {
      setError("Error occured\nPlease try again");
    }
    setLoading(false);
  }

  // update order status
  updateOrderStatus(OrderResponse payload) async {
    try {
      setLoading(true);
      final response = await OrderService.updateExistingOrderStatus(payload);
      onSuccess();
      return response['data'];
    } catch (e) {
      setError("Error occured\nPlease try again\n$e");
    }
    setLoading(false);
  }
}
