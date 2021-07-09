import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:beco_passenger/views/ChatScreen/ChatScreen.dart';

class GetRouteDetails extends StatelessWidget {
  final String selectedRoute;

  GetRouteDetails(this.selectedRoute, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

    return FutureBuilder<DocumentSnapshot>(
      future: routes.doc(selectedRoute).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          final user = FirebaseAuth.instance.currentUser;

          String driverName = data["driverName"];
          String driverUid = data["driverUid"];

          String passengerUid = user!.uid;
          String passengerName = "";

          String imageUrl = data["driverImageUrl"];

          Future getName() async {
            FirebaseFirestore.instance
                .collection('passengers')
                .doc(passengerUid)
                .get()
                .then((value) => passengerName = value["name"]);
          }

          getName();

          return ChatScreen(
            driverName,
            passengerName,
            driverUid,
            passengerUid,
            imageUrl,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
