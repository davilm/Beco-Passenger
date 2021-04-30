import 'package:flutter/material.dart';
import 'package:tela_de_login_beco/TelaDeLogin.dart';
import 'TelaDeCadastro01.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/Login.jpeg"),
            fit: BoxFit.fitHeight
          ),
          border: Border.all(width: 3, color: Colors.transparent),
        ),

        //Texto inferior
        child: Column(

          children: [
            Container(
              padding: EdgeInsets.only(left: 0, top: 550, right: 100),
              width: MediaQuery.of(context).size.width/1.2,
              child: Text("Viaje a hora que quiser, com segurança e privacidade",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16

              ),
              ),

            ),

            //Botão cadastrar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 38,
                width: MediaQuery.of(context).size.width/1.2,
                child: RaisedButton(
                  child: Text("Cadastrar",
                    style: TextStyle(
                        fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> CadastroCpf())
                    );
                  },
                ),
              ),
            ),

            //Botão entrar
            Container(
              child: Container(
                height: 38,
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: RaisedButton(
                  color: Colors.transparent,
                  child: Text("Entrar",
                    style: TextStyle(
                        fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  onPressed: (){

                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> TelaDeLogin())
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
