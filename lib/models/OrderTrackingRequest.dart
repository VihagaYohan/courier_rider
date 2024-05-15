class OrderTrackingRequest {
  final String orderId;
  final double latitude;
  final double longitude;

  OrderTrackingRequest(
      {required this.orderId, required this.latitude, required this.longitude});

  // serialize CourierType object to JSON
  Map<String, dynamic> toJson() {
    return {'orderId': orderId, 'latitude': latitude, 'longitude': longitude};
  }

  // deserialize CourierType object from Map
  factory OrderTrackingRequest.fromJson(Map<String, dynamic> json) =>
      OrderTrackingRequest(
          orderId: json['orderId'],
          latitude: json['latitude'],
          longitude: json['longitude']);
}
