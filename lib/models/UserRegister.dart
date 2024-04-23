class UserRegister {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  UserRegister(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber});

  // serialize user register object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
