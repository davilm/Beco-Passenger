import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/TelaDeCadasro02.dart';
import 'package:tela_de_login_beco/TelaDeCadastro04.dart';

class Senha extends StatefulWidget {
  @override
  _SenhaState createState() => _SenhaState();
}

class _SenhaState extends State<Senha> {
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemError = "";

  validarSenha() {
    String senha = _controllerSenha.text;

    if (senha.isNotEmpty && senha.length > 5) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Nome()));
    } else {
      setState(() {
        _mensagemError = "A senha deve conter mais de 5 digitos";
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
                  MaterialPageRoute(builder: (context) => TelaEmail()));
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
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),

                    //TCampo digitar nome
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: TextField(
                        controller: _controllerSenha,
                        cursorColor: Colors.black,
                        decoration:
                            InputDecoration(hintText: "Digite sua senha"),
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
