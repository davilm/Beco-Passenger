import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/shared/models/user_model.dart';
import 'package:tela_de_login_beco/views/SignIn/SignIn.dart';
import '../SignUp/SignUpCpf.dart';

class ChooseSign extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ChooseSign> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final newUser = new UserModel(null, null, null, null);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/Login.jpeg"),
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
                child: RaisedButton(
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpCpf(newUser: newUser)));
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
                child: RaisedButton(
                  color: Colors.transparent,
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
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
