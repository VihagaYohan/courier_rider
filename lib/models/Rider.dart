class Rider {
  String id;
  String name;
  String email;
  String phoneNumber;
  String role;
  String createdOn;

  Rider(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.role,
      required this.createdOn});

  // convert rider object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'createdOn': createdOn
    };
  }

  // create rider object from JSON
  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        role: json['role'],
        createdOn: json['createdOn']);
  }
}
