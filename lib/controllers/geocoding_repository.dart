import 'package:beco_passenger/models/geocoding_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:beco_passenger/.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/geocode/json?';

  final Dio _dio;

  GeocodingRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Geocoding> getLatLng({
    @required LatLng? latlng,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'latlng': '${latlng!.latitude},${latlng.longitude}',
        'key': googleAPIKey,
      },
    );
    if (response.statusCode == 200) {
      print('${latlng.latitude},${latlng.longitude}');
      print(response.statusCode);
      return Geocoding.fromMap(response.data);
    }
    return Future.error('Ops, problem with google api');
  }
}
