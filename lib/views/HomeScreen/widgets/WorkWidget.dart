import 'package:flutter/material.dart';

class WorkWidget extends StatelessWidget {
  const WorkWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Container(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  width: generalWidth,
                  child: Text(
                    "Deseja trabalhar conosco?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Container(
                width: generalWidth,
                padding: EdgeInsets.only(
                  left: 16,
                  right: MediaQuery.of(context).size.width / 2.7,
                  top: 2,
                ),
                child: Text(
                  "Baixe o Beco driver. Faça seu cadastro e torne-se parte você também do nosso time.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                width: generalWidth,
                height: 35,
                // color: Colors.red,
                padding: EdgeInsets.only(
                  left: 16,
                ),
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Quero ser motorista",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_forward),
                          color: Colors.white,
                          iconSize: 20,
                          onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
