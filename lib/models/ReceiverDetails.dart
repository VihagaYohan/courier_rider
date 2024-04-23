class ReceiverDetails {
  final String name;
  final String mobileNumber;
  final String address;
  final String? receiverNote;

  ReceiverDetails(
      {required this.name,
      required this.mobileNumber,
      required this.address,
      this.receiverNote});

  // convert receiver details object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobileNumber': mobileNumber,
      'address': address,
      'receiverNote': receiverNote
    };
  }
}
