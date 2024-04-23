// models
import 'package:courier_rider/models/models.dart';

class SenderDetailsResponse {
  Location location;
  String senderId;
  String name;
  String mobileNumber;
  String email;
  String pickUpDate;
  String pickUpTime;
  String address;
  String senderNotes;
  String id;

  SenderDetailsResponse({
    required this.location,
    required this.senderId,
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.pickUpDate,
    required this.pickUpTime,
    required this.address,
    required this.senderNotes,
    required this.id,
  });

  // convert Sender details response object to JSON
  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'senderId': senderId,
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'pickUpDate': pickUpDate,
      'pickUpTime': pickUpTime,
      'address': address,
      'senderNotes': senderNotes,
      'id': id
    };
  }

  // create sender details response object from JSON
  factory SenderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return SenderDetailsResponse(
        location: Location.fromJson(json['location']),
        senderId: json['senderId'],
        name: json['name'],
        mobileNumber: json['mobileNumber'],
        email: json['email'],
        pickUpDate: json['pickUpDate'],
        pickUpTime: json['pickUpTime'],
        address: json['address'],
        senderNotes: json['senderNotes'],
        id: json['_id']);
  }
}
