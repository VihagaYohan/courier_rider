class PaymentTypes {
  final String id;
  final String name;

  PaymentTypes({required this.id, required this.name});

  // convert payment type object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  // create payment types object from Json
  factory PaymentTypes.fromJson(Map<String, dynamic> json) {
    return PaymentTypes(id: json['_id'], name: json['name']);
  }
}
