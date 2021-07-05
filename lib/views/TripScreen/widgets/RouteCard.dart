import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RouteCard extends StatefulWidget {
  final String startTrip;
  final String endTrip;
  final Timestamp date;
  final String travelPrice;
  final String driverImageUrl;
  final String routeId;
  final Function(String) pickRouteId;

  RouteCard(
    this.startTrip,
    this.endTrip,
    this.date,
    this.travelPrice,
    this.driverImageUrl,
    this.routeId, {
    required this.pickRouteId,
    Key? key,
  }) : super(key: key);

  @override
  _RouteCardState createState() => _RouteCardState();
}

class _RouteCardState extends State<RouteCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: 140,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff551FFF),
          ),
          child: ElevatedButton(
            onPressed: () => widget.pickRouteId(widget.routeId),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Erick',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'R\$ 105',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/32.jpg",
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
