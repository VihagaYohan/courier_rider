class OrderTypes {
  final int id;
  final String name;
  final double cost;

  OrderTypes({required this.id, required this.name, required this.cost});

  // convert order types object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'cost': cost};
  }

  // create order types object from json
  factory OrderTypes.fromJson(Map<String, dynamic> json) {
    return OrderTypes(id: json['id'], name: json['name'], cost: json['cost']);
  }
}
