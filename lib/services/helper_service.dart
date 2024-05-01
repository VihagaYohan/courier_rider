// import 'dart:js_interop';

import 'package:courier_rider/models/models.dart';
import 'package:http/http.dart' as http;
// model
import 'dart:convert';
import 'package:courier_rider/models/CourierType.dart';
import 'package:courier_rider/models/PackageType.dart';
// import 'package:courier_rider/models/models.dart';

// endpoints
import 'package:courier_rider/services/endpoints.dart';

class HelperService {
  // get all shipment types
  static getShipmentTypes() async {
    try {
      List<CourierType> courierTypes = [];
      final response = await http.get(Uri.parse(Endpoints.courierTypes));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var eachItem in jsonData['data']) {
          final courierType = CourierType(
              id: eachItem['_id'],
              name: eachItem['name'],
              createdAt: eachItem['createdAt']);

          courierTypes.add(courierType);
        }
        return courierTypes;
      } else {
        throw Exception('Failed to load shipment types');
      }
    } catch (e) {
      throw Exception('Failed to load shipment types $e');
    }
  }

  // get all package types
  static getPackageTypes() async {
    try {
      List<PackageType> packageTypes = [];
      final response = await http.get(Uri.parse(Endpoints.packageTypes));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var item in jsonData['data']) {
          final packageType = PackageType(
              id: item['_id'],
              name: item['name'],
              createdAt: item['createdAt']);
          packageTypes.add(packageType);
        }
        return packageTypes;
      } else {
        throw Exception('Failed to load package types');
      }
    } catch (e) {
      throw Exception('Failed to load package types $e');
    }
  }

  // get all payment methods
  static getPaymentTypes() async {
    try {
      List<PaymentTypes> paymentTypes = [];
      final response = await http.get(Uri.parse(Endpoints.paymentTypes));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var item in jsonData['data']) {
          final paymentType = PaymentTypes(id: item['_id'], name: item['name']);
          paymentTypes.add(paymentType);
        }
        return paymentTypes;
      } else {
        throw Exception("Failed to load payment types");
      }
    } catch (e) {
      throw Exception("Failed to load payment types $e");
    }
  }

  // get all courier status
  static getAllCourierStatus() async {
    try {
      List<CourierStatus> courierStatus = [];
      final response = await http.get(Uri.parse(Endpoints.orderStatus));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var item in jsonData['data']) {
          final statusItem = CourierStatus(
              id: item['_id'],
              name: item['name'],
              createdAt: item['createdAt']);
          courierStatus.add(statusItem);
        }
        return courierStatus;
      } else {
        throw Exception("Failed to load courier status types");
      }
    } catch (e) {
      throw Exception("Failed to fetch courier status");
    }
  }

  // get shipment type by id
  static getShipmentTypeById(String typeId) async {
    try {
      final response =
          await http.get(Uri.parse(Endpoints(id: typeId).courierTypeById));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var item = jsonData['data'];
        CourierType courierItem = CourierType(
            id: item['_id'], name: item['name'], createdAt: item['createdAt']);
        return courierItem;
      } else {
        throw Exception("Courier type not found");
      }
    } catch (e) {
      throw Exception("Failed at fetching shipment type $e");
    }
  }

  // get package type by id
  static getPackageTypeById(String typeId) async {
    try {
      final response =
          await http.get(Uri.parse(Endpoints(id: typeId).packageTypeById));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var item = jsonData['data'];
        PackageType packageType = PackageType(
            id: item['_id'], name: item['name'], createdAt: item['createdAt']);
        return packageType;
      } else {
        throw Exception("Package type not found");
      }
    } catch (e) {
      throw Exception("Failed at fetching package type $e");
    }
  }
}
