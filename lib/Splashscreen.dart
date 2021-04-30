import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/LoginPage.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(
    seconds: 4,
    ),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()),);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        //SplashScreen
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Text("BECO",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        letterSpacing: 2,
                        decoration: TextDecoration.none
                    ),
                  )
              )
            ],
          ),

          //Efeito de Login
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CircularProgressIndicator(
              backgroundColor: Colors.black,

              ),
            ),
          )
        ],
      ),




    );
  }
}
