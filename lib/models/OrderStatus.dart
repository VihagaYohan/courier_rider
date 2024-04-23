class OrderStatus {
  final String id;
  final String name;

  OrderStatus({required this.id, required this.name});

  // convert Order status object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  // create order statues from JSON
  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(id: json['id'], name: json['name']);
  }
}
