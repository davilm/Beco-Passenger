import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/Outro.dart';
import 'package:tela_de_login_beco/TelaDeCadastro01.dart';
import 'package:tela_de_login_beco/TelaDeCadastro03.dart';

class TelaEmail extends StatefulWidget {
  @override
  _TelaEmailState createState() => _TelaEmailState();
}

class _TelaEmailState extends State<TelaEmail> {
  TextEditingController _controllerEmail = TextEditingController();
  String _mensagemError = "";

  validarEmail() {
    String email = _controllerEmail.text;

    if (email.isNotEmpty && email.contains("@")) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Senha()));
    } else {
      setState(() {
        _mensagemError = "Insira um Email Válido";
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastroCpf()));
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
                          "Insira seu endereço de Email",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),

                    //TCampo digitar nome
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: TextField(
                        controller: _controllerEmail,
                        cursorColor: Colors.black,
                        decoration:
                            InputDecoration(hintText: "name@exemple.com"),
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
                            validarEmail();
                          },
                        ),
                      ),
                    ),

                    Text(
                      _mensagemError,
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
