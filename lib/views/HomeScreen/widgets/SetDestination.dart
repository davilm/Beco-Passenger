import 'package:beco_passenger/core/core.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/TextFieldWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SetDestination extends StatelessWidget {
  final Function onChoosedRoute;

  SetDestination({
    required this.onChoosedRoute,
    Key? key,
  });

  CollectionReference routes = FirebaseFirestore.instance.collection('routes');

  String endTrip = "Para";

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: routes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong $snapshot.error"));
          }

          final routeDocs = snapshot.data!.docs;

          List citiesList = [];

          routeDocs.forEach((doc) {
            citiesList.add(doc["endTrip"]);

            citiesList = citiesList.toSet().toList();
          });

          return Column(
            children: [
              TextFieldWidget(
                Icons.place,
                endTrip,
                citiesList,
                onChoosedRoute: (city) => {
                  this.endTrip = city,
                },
              ),
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
                      onPressed: () {
                        onChoosedRoute(endTrip);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
