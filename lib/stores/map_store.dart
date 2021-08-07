import 'package:beco_passenger/controllers/directions_repository.dart';
import 'package:beco_passenger/controllers/geo_location_controller.dart';
import 'package:beco_passenger/controllers/geocoding_repository.dart';
import 'package:beco_passenger/models/directions_model.dart';
import 'package:beco_passenger/models/reverse_geocoding_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'map_store.g.dart';

class MapStore = _MapStoreBase with _$MapStore;

abstract class _MapStoreBase with Store {
  @observable
  GoogleMapController? _googleMapController;

  @observable
  CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(-12.0529923, -58.3138234), zoom: 4.0);

  ObservableList<Marker> markers = ObservableList<Marker>.of([]);

  @observable
  MarkerId? selectedMarker;

  @observable
  int markerIdCounter = 1;

  @observable
  LatLng myPosition = LatLng(0, 0);

  @observable
  late Marker marker;

  @observable
  Directions? info;

  @observable
  var myAddress;

  @observable
  var myCityName;

  @observable
  var fullAddress;

  @observable
  bool cityNameLoaded = false;

  @observable
  var routeDistance;

  @observable
  var routeDuration;

  @observable
  var directions;

  @observable
  int flag = 0;

  @observable
  String _startTrip = "";

  @observable
  String endTrip = "";

  @observable
  Timestamp date = Timestamp.now();

  @observable
  String price = "";

  @observable
  String selectedRoute = "void";

  @action
  void onMapCreated(GoogleMapController controller) {
    this._googleMapController = controller;

    addMyLocationMarker();
  }

  addMyLocationMarker() async {
    GeoLocationController().currentPosition().then((controller) => {
          myPosition = LatLng(controller.latitude, controller.longitude),
          getMyAddress(),
          _googleMapController!.animateCamera(
            CameraUpdate.newLatLng(myPosition),
          ),
          moveCameraToUserCurrentPosition(),
        });
  }

  @action
  moveCameraToUserCurrentPosition() {
    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: myPosition, zoom: 17.5),
      ),
    );
  }

  @action
  Future<void> getMyAddress() async {
    var address = await GeocodingRepository().getAddress(latlng: myPosition);

    myAddress = address.formattedAddress;
    myCityName = address.cityName;
    fullAddress = address.fullAddress;

    cityNameLoaded = true;
  }

  @action
  Future<ReverseGeocoding> getLatLng(String pos) async {
    var latLng = await GeocodingRepository().getLatLng(address: pos);

    print("latLng: ${latLng.latLng}");
    return latLng;
  }

  @action
  LatLng midPoint(double lat1, double long1, double lat2, double long2) {
    return new LatLng((lat1 + lat2) / 2, (long1 + long2) / 2);
  }

  @action
  addDestinationMarker() async {
    var pos = await getLatLng(endTrip);

    LatLng endTripPosition = pos.latLng;

    final String markerIdVal = 'destination';

    final MarkerId markerId = MarkerId(markerIdVal);

    var markerIndex = markers
        .indexWhere((element) => element.markerId == MarkerId('destination'));

    if (markerIndex != -1) {
      markers.removeAt(markerIndex);
    }

    markers.add(
      Marker(
        markerId: markerId,
        position: endTripPosition,
        infoWindow: InfoWindow(title: endTrip, snippet: 'Esse é seu destino'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {},
      ),
    );

    directions = await DirectionsRepository()
        .getDirections(origin: myPosition, destination: endTripPosition);

    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: midPoint(
          myPosition.latitude,
          myPosition.longitude,
          endTripPosition.latitude,
          endTripPosition.longitude,
        ),
        zoom: 7.0,
      )),
    );

    info = directions;
  }
}
