class UserInfo {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? address;
  final String role;
  final String? photoUrl;
  final String createdOn;
  final String token;

  const UserInfo(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      this.address,
      required this.role,
      this.photoUrl,
      required this.createdOn,
      required this.token});

  // serilize UserInfo object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'role': role,
      'photoUrl': photoUrl,
      'createdOn': createdOn,
      'token': token
    };
  }

  // deserialize UserInfo object from Map
  factory UserInfo.fromJson(Map<String, dynamic> map) => UserInfo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      createdOn: map['createdOn'] ?? '',
      token: map['token'] ?? '');
}
