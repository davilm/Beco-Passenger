import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '/core/core.dart';

import 'package:beco_passenger/api/Authentication.dart';

import 'package:beco_passenger/views/ChooseSign/ChooseSign.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/ChartWidget.dart';
import 'package:beco_passenger/views/ConfigurationScreen/ConfigurationScreen.dart';

import 'package:beco_passenger/shared/widgets/ArrowButtonWidget.dart';
import 'package:beco_passenger/shared/widgets/InfoCardWidget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = AppImages.faceLight;

    final double heightMarginTitle = MediaQuery.of(context).size.width / 5;
    final double widthMargin = MediaQuery.of(context).size.width / 40;
    final double widthMarginBody = MediaQuery.of(context).size.width / 8;

    final String firstName = "David";
    final String lastName = "Clerisseau";

    final String myTravels = "Minhas viagens";
    final String settings = "Configurações";

    final String joined = "Entrou";
    final String timeJoined = "6 meses atrás";

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Color(0xffF5F5F7),
      minimumSize: Size(10, 10),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Drawer(
          child: Padding(
            padding: EdgeInsets.only(left: widthMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heightMarginTitle),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: widthMarginBody),
                      child: ChartWidget(image),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Container(
                        color: Color(0xffD0D2DA),
                        height: 80,
                        width: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            joined,
                            style: GoogleFonts.beVietnam(
                                fontSize: 12, color: Color(0xff92959E)),
                          ),
                          Text(
                            timeJoined,
                            style: GoogleFonts.beVietnam(
                                fontSize: 12, color: Color(0xff15192C)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: widthMarginBody, top: 24),
                  child: Stack(
                    children: [
                      Text(
                        firstName,
                        style: AppTextStyles.firstName,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          lastName,
                          style: AppTextStyles.secondName,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: widthMarginBody,
                    top: heightMarginTitle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoCardWidget(myTravels, AppImages.languageLight),
                      Expanded(
                        child: SizedBox(),
                      ),
                      ArrowButtonWidget(() => {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MyTravelsScreen()),
                            // ),
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: widthMarginBody, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoCardWidget(settings, AppImages.configLight),
                      Expanded(
                        child: SizedBox(),
                      ),
                      ArrowButtonWidget(() => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfigurationScreen()),
                            ),
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: widthMarginBody, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF5F5F7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 120,
                    height: 42,
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () async {
                        String sign = await Authentication().signOut();
                        if (sign == "Sign Out") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseSign()));
                        } else {}
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              color: Color(0xfff55F7),
                              width: 14,
                              height: 14,
                              child: Image(
                                image: AssetImage(AppImages.signoutLight),
                              ),
                            ),
                          ),
                          Text(
                            "Sign Out",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff15192C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
