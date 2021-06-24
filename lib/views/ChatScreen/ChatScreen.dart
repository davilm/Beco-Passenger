import 'package:beco_passenger/core/core.dart';
import 'package:beco_passenger/views/ChatScreen/widgets/MessageBubble.dart';
import 'package:beco_passenger/views/ChatScreen/widgets/Messages.dart';
import 'package:beco_passenger/views/ChatScreen/widgets/NewMessage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;
    final double heightMargin = MediaQuery.of(context).size.height / 42;
    final double heightMarginTitle = MediaQuery.of(context).size.width / 11;

    final String title = "Erick";

    final _controller = TextEditingController();

    final bool belongsToMe = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: widthMargin, top: heightMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: IconButton(
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                ),
              ),
              SizedBox(height: heightMarginTitle),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.upTitle),
                    SizedBox(height: 5),
                    Container(
                      width: 30,
                      height: 2,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 30),
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 1.7,
                            child: Messages(),
                          ),
                          NewMessage()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
