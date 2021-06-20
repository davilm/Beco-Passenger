import 'package:flutter/material.dart';

class ArrowButtonWidget extends StatefulWidget {
  final VoidCallback func;

  ArrowButtonWidget(this.func);

  @override
  _ArrowButtonWidgetState createState() => _ArrowButtonWidgetState();
}

class _ArrowButtonWidgetState extends State<ArrowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Color(0xffF5F5F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 12,
          ),
          onPressed: widget.func,
        ),
      ),
    );
  }
}
