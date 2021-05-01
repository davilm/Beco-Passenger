import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/shared/models/user_model.dart';
import 'package:tela_de_login_beco/views/ChooseSign/ChooseSign.dart';
import 'package:tela_de_login_beco/views/SignUp/SignUpEmail.dart';

class SignUpCpf extends StatefulWidget {
  final UserModel newUser;

  SignUpCpf({Key key, @required this.newUser}) : super(key: key);

  @override
  _SignUpCpfState createState() => _SignUpCpfState();
}

class _SignUpCpfState extends State<SignUpCpf> {
  TextEditingController _cpfController = new TextEditingController();
  String _errorMessage = "";

  validarCpf() {
    String cpf = _cpfController.text;

    if (cpf.isNotEmpty && cpf.length == 14 && cpf.contains("-")) {
      widget.newUser.cpf = _cpfController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpEmail(newUser: widget.newUser),
        ),
      );
    } else {
      setState(() {
        _errorMessage = "Insira um CPF Válido/ Separando por '-'";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _cpfController.text = widget.newUser.cpf;
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
                  MaterialPageRoute(builder: (context) => ChooseSign()));
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
                          "Insira seu CPF",
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
                        controller: _cpfController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: "000-000-000-00",
                        ),
                        autofocus: true,
                      ),
                    ),

                    //Campo Botao
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 1.65,
                          bottom: 8,
                        ),
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
                            validarCpf();
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
