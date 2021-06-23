import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.38,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F7),
        // color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          suffixIcon: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
