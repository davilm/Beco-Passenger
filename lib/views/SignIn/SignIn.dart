import 'package:flutter/material.dart';

import 'package:beco_passenger/api/Authentication.dart';
import 'package:beco_passenger/shared/models/user_model.dart';
import 'package:beco_passenger/views/ChooseSign/ChooseSign.dart';
import 'package:beco_passenger/views/HomeScreen/HomeScreen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final UserModel _authData = UserModel("", "", "", "", "");

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
                  MaterialPageRoute(builder: (context) => ChooseSign()));
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
                child: TextFormField(
                  key: ValueKey('Email'),
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (value) => _authData.email = value,
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width / 1.09,
                child: TextFormField(
                  key: ValueKey('Password'),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                  onChanged: (value) => _authData.password = value,
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return 'Nome deve ter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
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
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Authentication()
                          .signIn(_authData.email, _authData.password);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
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
