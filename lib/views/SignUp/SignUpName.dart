import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/api/FirebaseAuth.dart';
import 'package:tela_de_login_beco/shared/models/user_model.dart';
import 'package:tela_de_login_beco/views/HomeScreen/HomeScreen.dart';
import 'package:tela_de_login_beco/views/SignUp/SignUpPassword.dart';

class SignUpName extends StatefulWidget {
  final UserModel newUser;

  SignUpName({Key key, @required this.newUser}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<SignUpName> {
  TextEditingController _nameController = TextEditingController();
  String _errorMessage = "";

  validarNome() {
    String name = _nameController.text;

    if (name.isNotEmpty && name.length > 5) {
      widget.newUser.name = _nameController.text;
      print("---------------------------------------------");
      print(widget.newUser.password);
      // newUser;
      FirebaseAuth().signUp(widget.newUser.email, widget.newUser.password);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = "Digite seu nome e sobrenome";
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
                MaterialPageRoute(builder: (context) => SignUpPassword()),
              );
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
                          "Qual seu nome?",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),

                    //TCampo digitar nome
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: TextField(
                        controller: _nameController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(hintText: "Nome completo"),
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
                            "Concluir",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            validarNome();
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
