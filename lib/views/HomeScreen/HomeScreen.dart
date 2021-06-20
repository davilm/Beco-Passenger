import 'package:flutter/material.dart';

import 'package:beco_passenger/views/HomeScreen/widgets/CreateRouteWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/DrawerWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/WorkWidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Container(
          height: 700,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://media.istockphoto.com/vectors/vector-city-map-vector-id826280312?k=6&m=826280312&s=170667a&w=0&h=Sa_vE8LCTr9ze5cLsmotHB2vrHHf6J0N6W4ADWDCq7c="),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height / 5.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff36B194),
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  height: 200,
                  child: WorkWidget(),
                ),
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.8,
                  color: Colors.blue,
                  child: CreateRouteWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
