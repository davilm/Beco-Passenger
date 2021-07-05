// import 'package:beco_passenger/views/TripScreen/widgets/RouteCard.dart';
import 'package:beco_passenger/views/TripScreen/widgets/RouteCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  final Function(String) pickRouteId;

  TripScreen({required this.pickRouteId, Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('routes')
            .where("endTrip", isEqualTo: "Quixeramobim")
            .orderBy('date')
            .snapshots(),
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
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: routeDocs.length,
            itemBuilder: (context, index) => RouteCard(
              routeDocs[index]['startTrip'],
              routeDocs[index]['endTrip'],
              routeDocs[index]['date'],
              routeDocs[index]['price'].toString(),
              routeDocs[index]['driverImageUrl'],
              routeDocs[index].id,
              pickRouteId: widget.pickRouteId,
              key: ValueKey(routeDocs[index].id),
            ),
          );
        },
      ),
    );
  }
}
