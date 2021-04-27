import 'package:flutter/material.dart';
import 'package:tela_login_de_teste_03/Cadastro.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Container Superior
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80)
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(""),
                    Container(
                      padding: EdgeInsets.only(top: 260, left: 290),
                      child: Align(
                          child: Text("Login",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white
                            ),)
                      ),
                    )
                  ],
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

              //Campo esqueci a senha
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 32),
                  child: Text('Esqueci a Senha!',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
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
                        "Entrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      color: Colors.blue,
                      onPressed: (){}
                  ),
                ),
              ),

              //Campo não tem conta
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 100),
                    child: Text("Não tem conta?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, top: 16),
                      child: Text("Clique Aqui",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cadastro()
                          )
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
