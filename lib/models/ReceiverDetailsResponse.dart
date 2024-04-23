// models
import 'package:courier_rider/models/models.dart';

class ReceiverDetailsResponse {
  Location location;
  String name;
  String mobileNumber;
  String address;
  String id;

  ReceiverDetailsResponse({
    required this.location,
    required this.name,
    required this.mobileNumber,
    required this.address,
    required this.id,
  });

  // convert reciever details response object to JSON
  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'name': name,
      'mobileNumber': mobileNumber,
      'address': address,
      'id': id
    };
  }

  // create receiver details response object from JSON
  factory ReceiverDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ReceiverDetailsResponse(
        location: Location.fromJson(json['location']),
        name: json['name'],
        mobileNumber: json['mobileNumber'],
        address: json['address'],
        id: json['_id']);
  }
}
