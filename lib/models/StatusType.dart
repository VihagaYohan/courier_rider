class Status {
  String id;
  String name;
  String? createdAt;

  Status({required this.id, required this.name, this.createdAt});

  // convert status to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }

  // create status object from JSON
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        id: json['_id'], name: json['name'], createdAt: json['createdAt']);
  }
}
