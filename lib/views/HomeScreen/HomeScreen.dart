import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/main.dart';
import 'package:tela_de_login_beco/views/ChooseSign/ChooseSign.dart';
import 'package:tela_de_login_beco/views/HomeScreen/widgets/DrawerWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(child: Text("Content")),
      drawer: DrawerWidget(),
    );
  }
}
