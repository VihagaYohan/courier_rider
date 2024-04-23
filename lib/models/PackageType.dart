class PackageType {
  final String id;
  final String name;
  final String? createdAt;

  PackageType({required this.id, required this.name, this.createdAt});

  // serialize PackageType object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'createdAt': createdAt};
  }

  // deserialize PackageType object from Map
  factory PackageType.fromJson(Map<String, dynamic> json) => PackageType(
      id: json['_id'], name: json['name'], createdAt: json['createdAt']);
}
