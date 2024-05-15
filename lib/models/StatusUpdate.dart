class StatusUpdate {
  final String orderId;
  final String statusId;

  StatusUpdate({required this.orderId, required this.statusId});

  // convert status update to JSON
  Map<String, dynamic> toJson() {
    return {'orderId': orderId, 'statusId': statusId};
  }

  // create status update from JSON
  factory StatusUpdate.fromJson(Map<String, dynamic> json) {
    return StatusUpdate(orderId: json['orderId'], statusId: json['orderId']);
  }
}
