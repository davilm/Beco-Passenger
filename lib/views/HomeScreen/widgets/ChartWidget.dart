import 'package:flutter/material.dart';

import '/core/core.dart';

class ChartWidget extends StatefulWidget {
  final String image;

  ChartWidget(this.image, {Key key}) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.0, end: 0.68).animate(_controller);
    _controller.forward();
  }

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: CircleAvatar(
                radius: 42,
                child: Image(image: AssetImage(widget.image)),
              ),
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 3.5,
                  value: _animation.value,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF6A00)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
