import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/views/HomeScreen/HomeScreen.dart';
import 'package:tela_de_login_beco/views/Splashscreen/Splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.black,
        accentColor: Colors.white),
  ));
}
