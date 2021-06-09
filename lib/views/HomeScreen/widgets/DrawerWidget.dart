import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/shared/widgets/InfoCardWidget.dart';
import '/core/core.dart';
import '/views/HomeScreen/widgets/ChartWidget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = AppImages.faceLight;

    final double heightMarginTitle = MediaQuery.of(context).size.width / 7;
    final double widthMargin = MediaQuery.of(context).size.width / 40;
    final double widthMarginBody = MediaQuery.of(context).size.width / 8;

    final String firstName = "David";
    final String lastName = "Clerisseau";

    final String myTravels = "Minhas viagens";
    final String settings = "Configurações";

    final String joined = "Entrou";
    final String timeJoined = "6 meses atrás";

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Drawer(
          child: Padding(
            padding: EdgeInsets.only(left: widthMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => {},
                  // onPressed: () => {Navigator.pop(context)},
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                ),
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
                      left: widthMarginBody, top: heightMarginTitle),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoCardWidget(myTravels, AppImages.languageLight),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            color: Color(0xffF5F5F7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 42,
                          height: 42,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
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
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF5F5F7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.bottomLeft,
                          width: 42,
                          height: 42,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
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
                    width: 100,
                    height: 42,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
