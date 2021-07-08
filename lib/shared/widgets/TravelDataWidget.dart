import 'package:beco_passenger/core/core.dart';
import 'package:flutter/material.dart';

class TravelDataWidget extends StatelessWidget {
  const TravelDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
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
                  "Fortaleza",
                  style: AppTextStyles.montserrat12MediumDark,
                ),
                SizedBox(height: 3),
                Text(
                  "Nov 14, 15:30",
                  style: AppTextStyles.montserrat10RegularGrey,
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quixeramobim",
                        style: AppTextStyles.montserrat12MediumDark,
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Nov 14, 18:27",
                        style: AppTextStyles.montserrat10RegularGrey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "212 km",
                        style: AppTextStyles.montserrat10SemiboldGrey,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Color(0xff92959E),
                        radius: 1,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "3 h  47 min",
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
