class SenderDetails {
  final String senderId;
  final String name;
  final String email;
  final String pickUpDate;
  final String pickUpTime;
  final String mobileNumber;
  final String address;
  final String? senderNotes;

  SenderDetails(
      {required this.senderId,
      required this.name,
      required this.email,
      required this.pickUpDate,
      required this.pickUpTime,
      required this.mobileNumber,
      required this.address,
      this.senderNotes});

  // convert SenderDetails object to JSON
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'name': name,
      'email': email,
      'pickUpDate': pickUpDate,
      'pickUpTime': pickUpTime,
      'mobileNumber': mobileNumber,
      'address': address,
      'senderNotes': senderNotes
    };
  }
}
