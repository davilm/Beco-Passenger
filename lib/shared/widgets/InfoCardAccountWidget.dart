import 'package:flutter/material.dart';
import '/core/core.dart';

class InfoCardAccountWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final String image;

  InfoCardAccountWidget(this.title, this.subTitle, this.image);

  @override
  _InfoCardAccountWidgetState createState() => _InfoCardAccountWidgetState();
}

class _InfoCardAccountWidgetState extends State<InfoCardAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
