import 'package:beco_passenger/controllers/directions_repository.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geocoder/geocoder.dart';

import 'package:beco_passenger/controllers/geo_location_controller.dart';
import 'package:beco_passenger/controllers/directions_model.dart';

const CameraPosition _initialCameraPosition =
    CameraPosition(target: LatLng(-12.0529923, -58.3138234), zoom: 4.0);

class MyMapWidget extends StatefulWidget {
  const MyMapWidget();

  @override
  State<StatefulWidget> createState() => MyMapWidgetState();
}

class MyMapWidgetState extends State<MyMapWidget> {
  MyMapWidgetState();

  static final LatLng center = const LatLng(-33.86711, 151.1947171);

  GoogleMapController? _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;

  LatLng myPosition = LatLng(0, 0);
  late Marker marker;
  Directions? _info;

  @override
  void initState() {
    _addMyLocationMarker();

    // super.dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    this._googleMapController = controller;
  }

  void _addDestinationMarker(LatLng pos) async {
    final int markerCount = markers.length;

    if (markerCount == 2) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: pos,
      infoWindow: markerCount == 0
          ? InfoWindow(
              title: "Inicio da rota",
              snippet: 'Sua viagem começa a partir daqui')
          : InfoWindow(title: "Destino", snippet: 'Esse é seu destino'),
      icon: markerCount == 0
          ? BitmapDescriptor.defaultMarker
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: () {
        _onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position);
      },
    );

    final directions = await DirectionsRepository()
        .getDirections(origin: myPosition, destination: pos);

    setState(() {
      markers[markerId] = marker;
      _info = directions;
    });
  }

  convertCoordinatesToAddress() async {
    try {
      final coordinates = new Coordinates(1.10, 45.50);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      // latitude: myPosition.latitude,
      // longitude: myPosition.longitude,

    } catch (e) {
      print(e);
    }
  }

  _addMyLocationMarker() async {
    final MarkerId markerId = MarkerId('marker_id_0');

    GeoLocationController().currentPosition().then((controller) => {
          myPosition = LatLng(
            controller.latitude,
            controller.longitude,
          ),
          marker = Marker(
            markerId: markerId,
            position: myPosition,
            infoWindow: InfoWindow(
                title: "Minha localização",
                snippet: 'Sua viagem começa a partir daqui'),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _onMarkerTapped(markerId);
            },
            onDragEnd: (LatLng position) {
              _onMarkerDragEnd(markerId, position);
            },
          ),

          // Get Directions
          setState(() {
            markers[markerId] = marker;
          }),
          _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: myPosition, zoom: 13.0)),
          ),
        });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 66),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Old position: ${tappedMarker.position}'),
                  Text('New position: $newPosition'),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final MarkerId? selectedId = selectedMarker;
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: {
            if (_info != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Color(0xff15192C),
                width: 5,
                points: _info!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
          onLongPress: (LatLng pos) {
            _addDestinationMarker(pos);
          },
        ),
        if (_info != null)
          Positioned(
            top: 45,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xff15192C),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Text(
                '${_info!.totalDistance}, ${_info!.totalDuration}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
