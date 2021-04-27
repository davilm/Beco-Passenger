import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tela_login_de_teste_03/Model/Usuario.dart';
class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _vaidarCampos(){

    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( nome.isNotEmpty ){
      if( email.isNotEmpty && email.contains("@")){
        if( senha.isNotEmpty && senha.length >6 ){

          setState(() {
            _mensagemErro = "";
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario( usuario );


        }else {
          setState(() {
            _mensagemErro = "Preencha a Senha";
          });
        }

      }else {
        setState(() {
          _mensagemErro = "Preencha com um Email Válido";
        });
      }

    }else {
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }


  }

  _cadastrarUsuario( Usuario usuario){

  FirebaseAuth auth = FirebaseAuth.instance;

  auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
  ).then((firebaseUser){

    setState(() {
      _mensagemErro = "Sucesso ao Cadastrar";
    });

  }).catchError((error){
    setState(() {
      _mensagemErro = "Erro ao Cadastrar usuario, Verifique os campos e tente novamente";
    });
  });



  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro")
      ),
      body:

      Center(
        child:

        //campo nome
        Container(
          padding: EdgeInsets.only(top: 32),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/1.2,
                height: 50,
                padding: EdgeInsets.only(
                    top: 4, left: 16, right: 16, bottom: 4
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5
                      )
                    ]
                ),
                child: TextField(
                  controller: _controllerNome,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle_rounded,
                        color: Colors.grey,
                      ),
                      hintText: "Nome Completo"
                  ),
                ),
              ),

              //Campo Email
              Container(
                padding: EdgeInsets.only(top: 32),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: TextField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email,
                              color: Colors.grey,
                            ),
                            hintText: "Email"
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //Campo Senha
              Container(
                padding: EdgeInsets.only(top: 32),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: TextField(
                        obscureText: true,
                        controller: _controllerSenha,
                        decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            hintText: "Senha"
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //Campo Botao
              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width/1.2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      color: Colors.blue,
                      onPressed: (){

                        _vaidarCampos();

                      }
                  ),
                ),
              ),

              //Mensagem erro
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _mensagemErro,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
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
