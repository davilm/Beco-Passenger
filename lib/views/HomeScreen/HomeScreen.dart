import 'package:beco_passenger/api/FirestoreRoutes.dart';
import 'package:beco_passenger/core/core.dart';
import 'package:beco_passenger/shared/widgets/TravelDataWidget.dart';
import 'package:beco_passenger/stores/map_store.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/AddOnsRowWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/ModalTopWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/SetDestination.dart';
import 'package:beco_passenger/views/TripInfoScreen/TripInfoScreen.dart';
import 'package:beco_passenger/views/TripScreen/TripScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:beco_passenger/views/HomeScreen/widgets/DrawerWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/MyMapWidget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapStore mapStore = MapStore();

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapStore = Provider.of<MapStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    final generalWidth = MediaQuery.of(context).size.width;
    final double fieldButtonHeight = 60;
    final double halfScreenWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Observer(builder: (_) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    MyMapWidget(),
                    if (mapStore.flag == 0 && mapStore.cityNameLoaded)
                      Positioned(
                        bottom: 0,
                        child: ModalTopWidget(
                          title: "Para onde?",
                          icon: "close",
                          onPressed: () => mapStore.flag = 0,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: mapStore.flag == 0
                      ? EdgeInsets.only(top: 20)
                      : EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: mapStore.flag == 0
                            ? MediaQuery.of(context).size.height / 2.8
                            : MediaQuery.of(context).size.height / 1.7,
                        child: Center(
                          child: Column(
                            children: [
                              if (mapStore.flag == 0 && mapStore.cityNameLoaded)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        Container(
                                          width: halfScreenWidth,
                                          child: Text(
                                            mapStore.fullAddress ?? "",
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
                              if (mapStore.flag == 0 && mapStore.cityNameLoaded)
                                SetDestination(
                                  myCityName: mapStore.myCityName ?? "",
                                  onChoosedRoute: (endTrip) => {
                                    mapStore.endTrip = endTrip,
                                    mapStore.flag++,
                                    mapStore.addDestinationMarker(),
                                  },
                                ),
                              if (mapStore.flag == 1)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: widthMargin * 5,
                                    right: widthMargin * 1.3,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (mapStore.info != null)
                                        TravelDataWidget(
                                          mapStore.directions,
                                          myCityName: mapStore.myCityName,
                                          endTrip: mapStore.endTrip,
                                          date: mapStore.date,
                                          flag: true,
                                        ),
                                      IconButton(
                                        onPressed: () {
                                          mapStore.flag = 0;
                                          mapStore.date = Timestamp.now();
                                          mapStore.price = "";
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
                              if (mapStore.flag == 1)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 90,
                                  child: TripScreen(
                                    mapStore.myCityName,
                                    mapStore.endTrip,
                                    pickRouteId: (routeId) {
                                      setState(() {
                                        if (routeId != "void") {
                                          mapStore.selectedRoute = routeId;
                                        } else {
                                          setState(() {
                                            mapStore.flag = 0;
                                          });
                                        }
                                      });
                                    },
                                    pickDate: (date) {
                                      setState(() {
                                        mapStore.date = date;
                                        print(date);
                                      });
                                    },
                                    pickTravelPrice: (price) {
                                      setState(() {
                                        mapStore.price = price;
                                        print(price);
                                      });
                                    },
                                  ),
                                ),
                              if (mapStore.flag == 1)
                                AddOnsRowWidget(
                                  description: "Assento de bebê",
                                  price: "+R\$ 20",
                                ),
                              if (mapStore.flag == 1)
                                AddOnsRowWidget(
                                  description: "Pegar em casa",
                                  price: "+R\$ 20",
                                ),
                              if (mapStore.flag == 1)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: widthMargin * 5 + 40,
                                    right: widthMargin * 5,
                                    bottom: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style:
                                            AppTextStyles.montserrat12BoldDark,
                                      ),
                                      Text(
                                        "R\$ ${mapStore.price}",
                                        style:
                                            AppTextStyles.montserrat12BoldDark,
                                      ),
                                    ],
                                  ),
                                ),
                              if (mapStore.flag == 1)
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "Definir Destino",
                                          style: AppTextStyles
                                              .montserrat14SemiboldWhite,
                                        ),
                                        onPressed: () async {
                                          String response;
                                          response = await addMeToRoute(
                                              mapStore.selectedRoute,
                                              mapStore.myAddress);
                                          if (response == 'esgotado') {
                                            setState(() {
                                              mapStore.flag = 0;
                                            });
                                            errorSnack(
                                              'Vagas esgotadas, escolha outro motorista',
                                              Theme.of(context).errorColor,
                                            );
                                          } else if (response == 'sucesso') {
                                            String routeId =
                                                mapStore.selectedRoute;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TripInfoScreen(
                                                    mapStore.directions,
                                                    myCityName:
                                                        mapStore.myCityName,
                                                    endTrip: mapStore.endTrip,
                                                    travelPrice: mapStore.price,
                                                    date: mapStore.date,
                                                    selectedRoute: routeId,
                                                  ),
                                                ));
                                            errorSnack(
                                              'Viagem marcada com sucesso!',
                                              Colors.green,
                                            );
                                            setState(() {
                                              mapStore.flag = 0;
                                              mapStore.selectedRoute = 'void';
                                            });
                                          } else {
                                            setState(() {
                                              mapStore.flag = 0;
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
        }),
      ),
    );
  }
}
