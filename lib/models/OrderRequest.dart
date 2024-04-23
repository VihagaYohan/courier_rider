import 'package:courier_rider/models/ReceiverDetails.dart';
import 'package:courier_rider/models/SenderDetails.dart';

class OrderRequest {
  final String? statusId;
  final String courierTypeId;
  final String packageTypeId;
  final String packageSize;
  final SenderDetails senderDetails;
  final ReceiverDetails? receiverDetails;
  final double? orderTotal;
  final String? paymentType;

  OrderRequest(
      {this.statusId,
      required this.courierTypeId,
      required this.packageTypeId,
      required this.packageSize,
      required this.senderDetails,
      this.receiverDetails,
      this.orderTotal,
      this.paymentType});

  // serialize Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'statusId': statusId,
      'courierTypeId': courierTypeId,
      'packageTypeId': packageTypeId,
      'packageSize': packageSize,
      'senderDetails': senderDetails,
      'receiverDetails': receiverDetails,
      'orderTotal': orderTotal,
      'paymentType': paymentType
    };
  } //
}
