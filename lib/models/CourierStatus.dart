class CourierStatus {
  final String id;
  final String name;
  final String? createdAt;

  CourierStatus({required this.id, required this.name, this.createdAt});

  // convert courier status object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }

  // create courier status object from JSON
  factory CourierStatus.fromJson(Map<String, dynamic> json) {
    return CourierStatus(
        id: json['_id'], name: json['name'], createdAt: json['createdAt']);
  }
}
