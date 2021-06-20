import 'package:flutter/material.dart';

import 'package:beco_passenger/views/SignIn/SignIn.dart';
import 'package:beco_passenger/views/SignUp/SignUpCpf.dart';

class ChooseSign extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ChooseSign> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Login.jpeg"),
            fit: BoxFit.fitHeight,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
          border: Border.all(width: 3, color: Colors.transparent),
        ),

        //Texto inferior
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 0,
                  top: screenSize.height / 1.5,
                  right: screenSize.width / 5),
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                "Viaje a hora que quiser, com segurança e privacidade",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            //Botão cadastrar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 38,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpCpf()));
                  },
                ),
              ),
            ),

            //Botão entrar
            Container(
              child: Container(
                height: 38,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
