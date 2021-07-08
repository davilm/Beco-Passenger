import 'package:beco_passenger/GetRouteDetails.dart';
import 'package:flutter/material.dart';

import 'package:beco_passenger/core/core.dart';

import 'package:beco_passenger/shared/widgets/TravelDataWidget.dart';

class TripInfoScreen extends StatefulWidget {
  String routeId;
  TripInfoScreen(this.routeId, {Key? key}) : super(key: key);

  @override
  _TripInfoScreenState createState() => _TripInfoScreenState();
}

class _TripInfoScreenState extends State<TripInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: Padding(
          padding: EdgeInsets.all(15),
          child: IconButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 15, right: 35, bottom: 3),
            width: 37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff00B7FE),
            ),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff00B7FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetRouteDetails(widget.routeId)),
                ),
              },
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Image(image: AssetImage(AppImages.chat)),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "Detalhes",
                            style: AppTextStyles.upTitle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 33, bottom: 5),
                            child: Text(
                              "da viagem",
                              style: AppTextStyles.botTitle,
                            ),
                          ),
                        ],
                      ),
                      Container(width: 30, height: 2, color: Colors.blue),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthMargin * 2),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff545FFF),
                        ),
                        child: Image(
                          image: AssetImage(AppImages.gardenCity),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 34,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Color(0xff551FFF),
                          ),
                          child: Center(
                            child: Text(
                              "R\$ 125",
                              style: AppTextStyles.montserrat13BoldWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
                  child: TravelDataWidget(),
                ),
              ],
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
                      "Encerrar viagem",
                      style: AppTextStyles.montserrat14SemiboldWhite,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
