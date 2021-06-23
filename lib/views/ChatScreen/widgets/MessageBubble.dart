import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final String userImage;
  final String time;
  final bool belongsToMe;
  final Key key;

  MessageBubble(
    this.message,
    this.userImage,
    this.time,
    this.belongsToMe, {
    required this.key,
  }) : super(key: key);

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: widget.belongsToMe ? 0 : 45,
          ),
          child: Row(
            mainAxisAlignment: widget.belongsToMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: widget.belongsToMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          widget.belongsToMe ? Color(0xff302C54) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: widget.belongsToMe
                            ? Radius.circular(10)
                            : Radius.circular(0),
                        bottomRight: widget.belongsToMe
                            ? Radius.circular(0)
                            : Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Color(0xffD0D2DA),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Text(
                        widget.message,
                        style: GoogleFonts.montserrat(
                          color: widget.belongsToMe
                              ? Colors.white
                              : Color(0xff15192C),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.time,
                    style: GoogleFonts.montserrat(
                      color:
                          widget.belongsToMe ? Colors.white : Color(0xff92959E),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!widget.belongsToMe)
          Positioned(
            bottom: 0,
            left: 0,
            right: 260,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.userImage,
              ),
            ),
          ),
      ],
    );
  }
}
