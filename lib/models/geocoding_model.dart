class Geocoding {
  final String formattedAddress;
  final String cityName;
  final String fullAddress;

  const Geocoding({
    required this.formattedAddress,
    required this.cityName,
    required this.fullAddress,
  });

  factory Geocoding.fromMap(Map<String, dynamic> map) {
    final data = Map<String, dynamic>.from(map['results'][0]);
    final formattedAddress = data['formatted_address'];

    final addressComponents = data['address_components'];
    final streetNumber = Map<String, dynamic>.from(addressComponents[0]);
    final route = Map<String, dynamic>.from(addressComponents[1]);
    final political = Map<String, dynamic>.from(addressComponents[2]);
    final address = Map<String, dynamic>.from(addressComponents[3]);

    final longStreetNumber = streetNumber['long_name'];
    final longRoute = route['long_name'];
    final longPolitical = political['long_name'];
    final cityName = address['long_name'];

    final fullAddress = " $longRoute, $longStreetNumber - $longPolitical";

    return Geocoding(
      formattedAddress: formattedAddress,
      cityName: cityName,
      fullAddress: fullAddress,
    );
  }
}
