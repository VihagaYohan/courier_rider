// models
import 'package:courier_rider/models/models.dart';

class OrderResponse {
  final String id;
  final String trackingId;
  late final Status status;
  final CourierType courierType;
  final PackageType packageType;
  final String packageSize;
  final SenderDetailsResponse senderDetails;
  final ReceiverDetailsResponse receiverDetails;
  final double orderTotal;
  final PaymentTypes paymentType;
  final String createdOn;
  final Rider? rider;

  OrderResponse(
      {required this.id,
      required this.trackingId,
      required this.status,
      required this.courierType,
      required this.packageType,
      required this.packageSize,
      required this.senderDetails,
      required this.receiverDetails,
      required this.orderTotal,
      required this.paymentType,
      required this.createdOn,
      this.rider});

  // serialize Order reponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trackingId': trackingId,
      'status': status,
      'courierType': courierType,
      'packageType': packageType,
      'packageSize': packageSize,
      'senderDetails': senderDetails,
      'receiverDetails': receiverDetails,
      'orderTotal': orderTotal,
      'paymentType': paymentType,
      'createdOn': createdOn,
      'riderName': rider
    };
  }

  // create order response object from JSON
  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
        id: json['id'],
        trackingId: json['trackingId'],
        status: json['status'],
        courierType: json['courierType'],
        packageType: json['packageType'],
        packageSize: json['packageSize'],
        senderDetails: json['senderDetails'],
        receiverDetails: json['receiverDetails'],
        orderTotal: json['orderTotal'],
        paymentType: json['paymentType'],
        createdOn: json['createdOn'],
        rider: json['rider']);
  }
}
