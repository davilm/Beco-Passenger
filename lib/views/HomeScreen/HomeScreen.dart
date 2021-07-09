import 'package:beco_passenger/core/core.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/SetDestination.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beco_passenger/api/FirestoreRoutes.dart';

import 'package:beco_passenger/views/HomeScreen/widgets/DrawerWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/MyMapWidget.dart';
import 'package:beco_passenger/views/TripInfoScreen/TripInfoScreen.dart';
import 'package:beco_passenger/views/TripScreen/TripScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myFlag = 0;

  String startTrip = "";
  String endTrip = "";
  late Timestamp date;

  // var formattedDate = DateFormat('hh:mm a').format(date);

  String price = "";

  String selectedRoute = "void";

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
        child: Column(
          children: [
            Container(
              height: 400,
              child: MyMapWidget(),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              child: Center(
                child: Column(
                  children: [
                    if (myFlag == 0)
                      SetDestination(
                        onChoosedRoute: (startTrip, endTrip) => {
                          this.startTrip = startTrip,
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
                          startTrip,
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
                                response = await addMeToRoute(selectedRoute);
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
                                              TripInfoScreen(routeId)));
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
    );
  }
}
