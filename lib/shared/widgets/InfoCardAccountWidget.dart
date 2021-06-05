import 'package:flutter/material.dart';
import '/core/core.dart';

class InfoCardAccountWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final String image;

  InfoCardAccountWidget(this.title, this.subTitle, this.image, {Key key})
      : super(key: key);

  @override
  _InfoCardAccountWidgetState createState() => _InfoCardAccountWidgetState();
}

class _InfoCardAccountWidgetState extends State<InfoCardAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            child: Image(image: AssetImage(widget.image)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: AppTextStyles.text14),
                SizedBox(height: 5),
                Text(widget.subTitle, style: AppTextStyles.text10),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              alignment: Alignment.bottomLeft,
              width: 42,
              height: 42,
              // color: Colors.red,
              child: Center(
                child: Icon(Icons.arrow_forward_ios, size: 12),
              ),
              color: Color(0xffF5F5F7),
            ),
          ),
        ],
      ),
    );
  }
}
