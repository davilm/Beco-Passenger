import 'package:flutter/material.dart';

import 'package:beco_passenger/shared/models/user_model.dart';
import 'package:beco_passenger/views/SignUp/SignUpEmail.dart';
import 'package:beco_passenger/views/SignUp/SignUpName.dart';

class SignUpPassword extends StatefulWidget {
  final UserModel newUser;
  SignUpPassword(this.newUser);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<SignUpPassword> {
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = "";

  validarSenha() {
    String password = _passwordController.text;

    if (password.isNotEmpty && password.length > 5) {
      widget.newUser.password = _passwordController.text;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpName(widget.newUser)),
      );
    } else {
      setState(() {
        _errorMessage = "A senha deve conter mais de 5 digitos";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpEmail(widget.newUser)));
            }),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.transparent)),

            //Campo insira cpf
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 110, left: 11),
                        child: Text(
                          "Crie a senha da sua conta",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    //TCampo digitar nome
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: TextField(
                        controller: _passwordController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        decoration:
                            InputDecoration(hintText: "Digite sua senha"),
                        autofocus: true,
                      ),
                    ),

                    //Campo Botao
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 1.65,
                            bottom: 8),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.black,
                          child: Text(
                            "Continuar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            validarSenha();
                          },
                        ),
                      ),
                    ),

                    Text(
                      _errorMessage,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
