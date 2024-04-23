class CourierType {
  final String id;
  final String name;
  final String? createdAt;

  CourierType({required this.id, required this.name, this.createdAt});

  // serialize CourierType object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'createdAt': createdAt};
  }

  // deserialize CourierType object from Map
  factory CourierType.fromJson(Map<String, dynamic> json) => CourierType(
      id: json['_id'], name: json['name'], createdAt: '[createdAt]');
}
