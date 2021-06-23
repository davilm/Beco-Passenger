import 'package:flutter/material.dart';
import 'package:beco_passenger/shared/models/user_model.dart';
import 'package:beco_passenger/views/ChooseSign/ChooseSign.dart';
import 'package:beco_passenger/views/SignUp/SignUpEmail.dart';

class SignUpCpf extends StatefulWidget {
  SignUpCpf({Key? key}) : super(key: key);

  @override
  _SignUpCpfState createState() => _SignUpCpfState();
}

class _SignUpCpfState extends State<SignUpCpf> {
  TextEditingController _cpfController = TextEditingController();
  String _errorMessage = "";

  final newUser = new UserModel("", "", "", "", "");

  validarCpf() {
    String cpf = newUser.cpf;
    if (cpf.isNotEmpty && cpf.length == 14 && cpf.contains("-")) {
      newUser.cpf = _cpfController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpEmail(newUser),
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
    _cpfController.text = newUser.cpf;

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

                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: TextFormField(
                        key: ValueKey('Cpf'),
                        decoration: InputDecoration(
                          hintText: "000-000-000-00",
                          labelText: 'CPF',
                        ),
                        onChanged: (value) => newUser.cpf = value,
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
