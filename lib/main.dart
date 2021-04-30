import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/Splashscreen.dart';

void main(){

  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
      secondaryHeaderColor: Colors.black,
      accentColor: Colors.white
    ),
  ));
}