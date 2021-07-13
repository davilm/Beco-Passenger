import 'package:beco_passenger/models/directions_model.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beco_passenger/core/core.dart';

import 'package:intl/intl.dart';

class TravelDataWidget extends StatelessWidget {
  final Directions totalDistance;
  final String myCityName;
  final String endTrip;
  final Timestamp date;
  final bool flag;

  const TravelDataWidget(
    this.totalDistance, {
    required this.myCityName,
    required this.endTrip,
    required this.date,
    this.flag = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: flag ? 100 : 130,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff15192C),
                radius: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CircleAvatar(
                  backgroundColor: Color(0xff15192C),
                  radius: 1,
                ),
              ),
              CircleAvatar(
                backgroundColor: Color(0xff15192C),
                radius: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CircleAvatar(
                  backgroundColor: Color(0xff15192C),
                  radius: 1,
                ),
              ),
              CircleAvatar(
                backgroundColor: Color(0xff15192C),
                radius: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 5,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  myCityName,
                  style: AppTextStyles.montserrat12MediumDark,
                ),
                SizedBox(height: 3),
                Text(
                  DateFormat("dd 'de' MMMM 'de' yyyy 'às' kk:mm:a")
                      .format(date.toDate()),
                  style: AppTextStyles.montserrat10RegularGrey,
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        endTrip,
                        style: AppTextStyles.montserrat12MediumDark,
                      ),
                      SizedBox(height: 3),
                      Text(
                        "",
                        style: AppTextStyles.montserrat10RegularGrey,
                      ),
                    ],
                  ),
                ),
                if (flag == false)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${totalDistance.totalDistance}",
                          style: AppTextStyles.montserrat10SemiboldGrey,
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Color(0xff92959E),
                          radius: 1,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${totalDistance.totalDuration}",
                          style: AppTextStyles.montserrat10SemiboldGrey,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
