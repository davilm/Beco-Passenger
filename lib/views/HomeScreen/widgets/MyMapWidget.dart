import 'package:beco_passenger/api/FirestoreRoutes.dart';
import 'package:beco_passenger/controllers/directions_repository.dart';
import 'package:beco_passenger/controllers/geocoding_repository.dart';
import 'package:beco_passenger/core/core.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/SetDestination.dart';
import 'package:beco_passenger/views/TripInfoScreen/TripInfoScreen.dart';
import 'package:beco_passenger/views/TripScreen/TripScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geocoder/geocoder.dart';

import 'package:beco_passenger/controllers/geo_location_controller.dart';
import 'package:beco_passenger/models/directions_model.dart';

const CameraPosition _initialCameraPosition =
    CameraPosition(target: LatLng(-12.0529923, -58.3138234), zoom: 4.0);

class MyMapWidget extends StatefulWidget {
  const MyMapWidget({Key? key});

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

  var myAddress;
  var myCityName;

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

  Future<void> _getMyAddress() async {
    var address = await GeocodingRepository().getLatLng(latlng: myPosition);

    setState(() {
      myAddress = address.formattedAddress;
      myCityName = address.cityName;
    });
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

          _getMyAddress(),

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

  String startTrip = "";
  String endTrip = "";
  late Timestamp date;
  String price = "";
  String selectedRoute = "void";
  int myFlag = 0;

  errorSnack(message, color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: Duration(seconds: 5),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    final generalWidth = MediaQuery.of(context).size.width;
    final double fieldButtonHeight = 60;
    return Column(
      children: [
        Container(
          height: 400,
          child: Stack(
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
                  left: MediaQuery.of(context).size.width / 3,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          child: Center(
            child: Column(
              children: [
                if (myFlag == 0)
                  Padding(
                    padding: EdgeInsets.only(
                      left: widthMargin * 5,
                      right: widthMargin * 5,
                      bottom: 10,
                    ),
                    child: Container(
                      height: fieldButtonHeight,
                      width: generalWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffD0D2DA),
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 15),
                            child: Icon(
                              Icons.gps_fixed,
                              color: Color(0xff92959E),
                              size: 30.0,
                            ),
                          ),
                          if (myAddress != null)
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                myAddress,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff92959E),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                if (myFlag == 0)
                  SetDestination(
                    onChoosedRoute: (endTrip) => {
                      this.endTrip = endTrip,
                      setState(() {
                        myFlag++;
                      }),
                    },
                  ),
                if (myFlag == 1)
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 140,
                    child: TripScreen(
                      myCityName,
                      endTrip,
                      pickRouteId: (routeId) {
                        setState(() {
                          if (routeId != "void") {
                            this.selectedRoute = routeId;
                          } else {
                            setState(() {
                              myFlag = 0;
                            });
                          }
                        });
                      },
                      pickDate: (date) {
                        setState(() {
                          this.date = date;
                          print(date);
                        });
                      },
                      pickTravelPrice: (price) {
                        setState(() {
                          this.price = price;
                          print(price);
                        });
                      },
                    ),
                  ),
                if (myFlag == 1)
                  Padding(
                    padding: EdgeInsets.only(
                      left: widthMargin * 5,
                      right: widthMargin * 5,
                      bottom: 20,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff15192C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Definir Destino",
                            style: AppTextStyles.montserrat14SemiboldWhite,
                          ),
                          onPressed: () async {
                            String response;
                            response =
                                await addMeToRoute(selectedRoute, myAddress);
                            if (response == 'esgotado') {
                              setState(() {
                                myFlag = 0;
                              });
                              errorSnack(
                                'Vagas esgotadas, escolha outro motorista',
                                Theme.of(context).errorColor,
                              );
                            } else if (response == 'sucesso') {
                              String routeId = selectedRoute;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TripInfoScreen(
                                      myCityName: myCityName,
                                      endTrip: endTrip,
                                      travelPrice: price,
                                      date: date,
                                      selectedRoute: routeId,
                                    ),
                                  ));
                              errorSnack(
                                'Viagem marcada com sucesso!',
                                Colors.green,
                              );
                              setState(() {
                                myFlag = 0;
                                selectedRoute = 'void';
                              });
                            } else {
                              setState(() {
                                myFlag = 0;
                              });
                              errorSnack(
                                response,
                                Theme.of(context).errorColor,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
