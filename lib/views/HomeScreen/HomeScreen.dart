import 'package:beco_passenger/api/FirestoreRoutes.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/MyMapWidget.dart';
import 'package:beco_passenger/views/TripScreen/TripScreen.dart';
import 'package:flutter/material.dart';

import 'package:beco_passenger/views/HomeScreen/widgets/SetDestination.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/DrawerWidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String selectedRoute = "Gwo9mVet7JJMi2Je8yRw";

  int myFlag = 0;

  String routeId = 'void';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                        onChoosedRoute: () => {
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
                          pickRouteId: (value) {
                            setState(() {
                              routeId = value;
                              print(routeId);
                            });
                          },
                        ),
                      ),
                    if (myFlag == 1)
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Definir Destino",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () async {
                            String response;
                            response = await addMeToRoute(routeId);
                            if (response == 'esgotado') {
                              setState(() {
                                myFlag = 0;
                              });
                              errorSnack(
                                'Vagas esgotadas, escolha outro motorista',
                                Theme.of(context).errorColor,
                              );
                            } else if (response == 'sucesso') {
                              setState(() {
                                myFlag = 0;
                              });
                              errorSnack(
                                'Viagem marcada com sucesso!',
                                Colors.green,
                              );
                            } else {
                              errorSnack(
                                response,
                                Theme.of(context).errorColor,
                              );
                            }
                          },
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
