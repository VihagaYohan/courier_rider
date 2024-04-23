class Location {
  String type;
  List<dynamic> coordinates;
  String formatedAddress;
  String street;
  String city;
  String country;

  Location({
    required this.type,
    required this.coordinates,
    required this.formatedAddress,
    required this.street,
    required this.city,
    required this.country,
  });

  // serialize Location object to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
      'formatedAddress': formatedAddress,
      'street': street,
      'city': city,
      'county': country
    };
  }

  // create location object from JSON
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        type: json['type'],
        coordinates: json['coordinates'],
        formatedAddress: json['formatedAddress'],
        street: json['street'],
        city: json['city'],
        country: json['country']);
  }
}
