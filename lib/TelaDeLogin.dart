import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/LoginPage.dart';

class TelaDeLogin extends StatefulWidget {
  @override
  _TelaDeLoginState createState() => _TelaDeLoginState();
}

class _TelaDeLoginState extends State<TelaDeLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }),
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      //Campo Email, CPF, Telefone
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.transparent),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width / 1.09,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width / 1.09,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                ),
              ),

              //Campo Esqueci Minha Senha
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "Esqueci minha senha",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                ),
              ),

              //Botao entrar
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.4),
                child: Container(
                  decoration: BoxDecoration(),
                  height: 38,
                  width: MediaQuery.of(context).size.width / 1.09,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
