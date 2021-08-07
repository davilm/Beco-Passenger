import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalTopWidget extends StatelessWidget {
  const ModalTopWidget({
    required this.title,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;

  final String icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 0, //extend the shadow
                offset: Offset(
                  0, // Move to right 10  horizontally
                  -2.0, // Move to bottom 10 Vertically
                ),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 12,
              bottom: 12,
              left: widthMargin * 5,
              right: widthMargin * 1.3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignmnt: CrossAxisAlignment.center,
              children: [
                Text(
                  "Para onde?",
                  style: GoogleFonts.montserrat(
                    color: Color(0xff15192C),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () => onPressed,
                  icon: Icon(
                    Icons.close,
                    color: Color(0xff15192C),
                    size: 25.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Color(0xffD0D2DA),
        ),
      ],
    );
  }
}
