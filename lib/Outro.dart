import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/LoginPage.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {


  bool _estaSelecionado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,


        appBar: AppBar(
          title: Text("Cadastro",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> LoginPage()
                    )
                );
              }
          ),
        ),

        //Container principal
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.transparent)
              ),

              //Campo insira cpf
              child: Container(
                width: double.infinity,

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 110,left:11),
                          child: Text("Insira seu nome completo",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),

                      //TCampo digitar nome
                      Container(
                        width: MediaQuery.of(context).size.width/1.09,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintText: "Name sobrenome"
                          ),

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 230),
                        child: Text("Insira seu CPF",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                        ),
                      ),

                      //TCampo digitar cpf
                      Container(
                        width: MediaQuery.of(context).size.width/1.09,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintText: "000-000-000-00"
                          ),

                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 110,left:11),
                          child: Text("Insira seu endereço de email",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),


                      //TCampo digitar email
                      Container(
                        width: MediaQuery.of(context).size.width/1.09,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintText: "name@exemplo.com"
                          ),

                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 110,left:11),
                          child: Text("Crie a senha da sua conta",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),


                      //TCampo digitar senha
                      Container(
                        width: MediaQuery.of(context).size.width/1.09,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintText: "Digite sua senha"
                          ),

                        ),
                      ),

                      Row(

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 120, left: 20),
                            child: Checkbox(
                              activeColor: Colors.black,
                              value: _estaSelecionado,
                              onChanged: (bool valor){
                                setState(() {
                                  _estaSelecionado = valor;
                                });
                              },
                            ),


                          ),
                          SizedBox(
                            child: Container(
                              margin: EdgeInsets.only(top: 150, left: 10),
                              height: 75,
                              width: 260,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 3, color: Colors.transparent)
                              ),

                              child: Text("Confirmo que tenho 18 anos de idade,  concordo  com  os  Termos  e  Condições  e  reconheço  a  Politica  de  Privacidade.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,

                                ),
                              ),
                            ),
                          ),

                        ],
                      ),


                      //Campo Botao
                      Container(
                        width: MediaQuery.of(context).size.width/1.09,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            color: Colors.black,
                            child: Text("Concluir Cadastro",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            onPressed: (){
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
          ],
        )
    );
  }
}
