import 'package:flutter/material.dart';

import 'package:beco_passenger/views/HomeScreen/widgets/DrawerWidget.dart';
import 'package:beco_passenger/views/HomeScreen/widgets/MyMapWidget.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: MyMapWidget(),
      ),
    );
  }
}
