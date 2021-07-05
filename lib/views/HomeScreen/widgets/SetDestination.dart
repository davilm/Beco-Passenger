import 'package:flutter/material.dart';

class SetDestination extends StatefulWidget {
  final Function onChoosedRoute;

  SetDestination({required this.onChoosedRoute, Key? key}) : super(key: key);

  @override
  State<SetDestination> createState() => _SetDestinationState();
}

class _SetDestinationState extends State<SetDestination> {
  String cityName = "Vou viajar para ...";

  List cityList = [
    'Fortaleza',
    'Quixeramobim',
    'Quixadá',
    'Canindé',
    'Guaramiranga',
    'Eusébio',
    'Caucaia',
  ];

  @override
  Widget build(BuildContext context) {
    final generalWidth = MediaQuery.of(context).size.width;
    final double fieldButtonHeight = 60;
    final String selectedRoute = "Gwo9mVet7JJMi2Je8yRw";

    final double widthMarginBody = MediaQuery.of(context).size.width / 8;

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: widthMarginBody, right: 30, top: 4, bottom: 16),
            child: Container(
              height: fieldButtonHeight,
              width: generalWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffD0D2DA),
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Icon(
                      Icons.gps_fixed,
                      color: Color(0xff92959E),
                      size: 30.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Fortaleza",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff92959E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widthMarginBody, right: 30, top: 4, bottom: 16),
            child: Container(
              height: fieldButtonHeight,
              width: generalWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffD0D2DA),
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Icon(
                      Icons.place,
                      color: Color(0xff92959E),
                      size: 30.0,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: DropdownButton(
                      underline: Container(color: Colors.transparent),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.transparent,
                      ),
                      items: cityList.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      hint: Text(
                        cityName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff92959E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onChanged: (city) {
                        setState(() {
                          cityName = city.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widthMarginBody, right: 30, top: 4, bottom: 16),
            child: Container(
              height: fieldButtonHeight,
              width: generalWidth,
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
                onPressed: () {
                  widget.onChoosedRoute();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
