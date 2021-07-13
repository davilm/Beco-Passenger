import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReverseGeocoding {
  final LatLng latLng;

  const ReverseGeocoding({
    required this.latLng,
  });

  factory ReverseGeocoding.fromMap(Map<String, dynamic> map) {
    final data = Map<String, dynamic>.from(map['results'][0]);

    final addressComponents = data['geometry']['location'];

    final lat = addressComponents['lat'];
    final lng = addressComponents['lng'];

    final LatLng latLng = LatLng(lat, lng);

    return ReverseGeocoding(
      latLng: latLng,
    );
  }
}
