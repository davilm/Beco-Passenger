import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Geocoding {
  final String formattedAddress;
  final String cityName;

  const Geocoding({
    required this.formattedAddress,
    required this.cityName,
  });

  factory Geocoding.fromMap(Map<String, dynamic> map) {
    final data = Map<String, dynamic>.from(map['results'][0]);
    final formattedAddress = data['formatted_address'];

    final addressComponents = data['address_components'];
    final address = Map<String, dynamic>.from(addressComponents[3]);

    final cityName = address['long_name'];

    return Geocoding(
      formattedAddress: formattedAddress,
      cityName: cityName,
    );
  }
}
