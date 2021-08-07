import 'package:beco_passenger/api/FirestoreRoutes.dart';
import 'package:beco_passenger/controllers/directions_repository.dart';
import 'package:beco_passenger/controllers/geocoding_repository.dart';
import 'package:beco_passenger/core/core.dart';
import 'package:beco_passenger/models/reverse_geocoding_model.dart';
import 'package:beco_passenger/shared/widgets/TravelDataWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/AddOnsRowWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/SetDestination.dart';
import 'package:beco_passenger/views/TripInfoScreen/TripInfoScreen.dart';
import 'package:beco_passenger/views/TripScreen/TripScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  var fullAddress;
  var routeDistance;
  var routeDuration;
  var directions;

  String startTrip = "";
  String endTrip = "";
  Timestamp date = Timestamp.now();
  String price = "";
  String selectedRoute = "void";
  int myFlag = 0;
  bool cityNameLoaded = false;

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
    var address = await GeocodingRepository().getAddress(latlng: myPosition);

    setState(() {
      myAddress = address.formattedAddress;
      myCityName = address.cityName;
      fullAddress = address.fullAddress;
    });

    cityNameLoaded = true;
  }

  Future<ReverseGeocoding> _getLatLng(String pos) async {
    var latLng = await GeocodingRepository().getLatLng(address: pos);

    print("latLng: $latLng.latLng");
    return latLng;
  }

  LatLng midPoint(double lat1, double long1, double lat2, double long2) {
    return new LatLng((lat1 + lat2) / 2, (long1 + long2) / 2);
  }

  void _addDestinationMarker() async {
    var pos = await _getLatLng(endTrip);

    LatLng endTripPosition = pos.latLng;

    final String markerIdVal = 'marker_id_2';

    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: endTripPosition,
      infoWindow: InfoWindow(title: endTrip, snippet: 'Esse é seu destino'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: () {
        _onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position);
      },
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

    setState(() {
      markers[markerId] = marker;
      _info = directions;
    });
  }

  _addMyLocationMarker() async {
    final MarkerId markerId = MarkerId('marker_id_0');

    GeoLocationController().currentPosition().then((controller) => {
          myPosition = LatLng(
            controller.latitude,
            controller.longitude,
          ),

          _getMyAddress(),
          // Get Directions

          _googleMapController!.animateCamera(
            CameraUpdate.newLatLng(myPosition),
          ),

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
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
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
                // onLongPress: (LatLng pos) {
                //   _addDestinationMarker(pos);
                // },
              ),
              if (_info != null)
                Positioned(
                  top: 45,
                  left: MediaQuery.of(context).size.width / 4,
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
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0, // soften the shadow
                            spreadRadius: 0, //extend the shadow
                            offset: Offset(
                              0, // Move to right 10  horizontally
                              -2.0, // Move to bottom 10 Vertically
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          left: widthMargin * 5,
                          right: widthMargin * 1.3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (myFlag == 0)
                              Text(
                                "Para onde?",
                                style: GoogleFonts.montserrat(
                                  color: Color(0xff15192C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            if (myFlag == 0)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    myFlag = 0;
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Color(0xff15192C),
                                  size: 25.0,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (myFlag == 0)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xffD0D2DA),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: myFlag == 0
                ? EdgeInsets.only(top: 20)
                : EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: myFlag == 0
                      ? MediaQuery.of(context).size.height / 2.8
                      : MediaQuery.of(context).size.height / 1.7,
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
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 15,
                                    ),
                                    child: Icon(
                                      Icons.gps_fixed,
                                      color: Color(0xff15192C),
                                      size: 30.0,
                                    ),
                                  ),
                                  if (fullAddress != null)
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        fullAddress,
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
                        if (myFlag == 0 && cityNameLoaded == true)
                          SetDestination(
                            myCityName: myCityName,
                            onChoosedRoute: (endTrip) => {
                              setState(
                                () {
                                  this.endTrip = endTrip;
                                  myFlag++;
                                },
                              ),
                              _addDestinationMarker(),
                            },
                          ),
                        if (myFlag == 1)
                          Padding(
                            padding: EdgeInsets.only(
                              left: widthMargin * 5,
                              right: widthMargin * 1.3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_info != null)
                                  TravelDataWidget(
                                    directions,
                                    myCityName: myCityName,
                                    endTrip: endTrip,
                                    date: date,
                                    flag: true,
                                  ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      myFlag = 0;
                                      date = Timestamp.now();
                                      price = "";
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Color(0xff15192C),
                                    size: 25.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (myFlag == 1)
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 90,
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
                          AddOnsRowWidget(
                            description: "Assento de bebê",
                            price: "+R\$ 20",
                          ),
                        if (myFlag == 1)
                          AddOnsRowWidget(
                            description: "Pegar em casa",
                            price: "+R\$ 20",
                          ),
                        if (myFlag == 1)
                          Padding(
                            padding: EdgeInsets.only(
                              left: widthMargin * 5 + 40,
                              right: widthMargin * 5,
                              bottom: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyles.montserrat12BoldDark,
                                ),
                                Text(
                                  "R\$ $price",
                                  style: AppTextStyles.montserrat12BoldDark,
                                ),
                              ],
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
                                    style:
                                        AppTextStyles.montserrat14SemiboldWhite,
                                  ),
                                  onPressed: () async {
                                    String response;
                                    response = await addMeToRoute(
                                        selectedRoute, myAddress);
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
                                            builder: (context) =>
                                                TripInfoScreen(
                                              directions,
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
            ),
          ),
        ),
      ],
    );
  }
}
