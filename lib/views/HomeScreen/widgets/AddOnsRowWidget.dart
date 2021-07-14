import 'package:beco_passenger/core/core.dart';
import 'package:flutter/material.dart';

class AddOnsRowWidget extends StatefulWidget {
  final String description;
  final String price;
  const AddOnsRowWidget({
    required this.description,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<AddOnsRowWidget> createState() => _AddOnsRowWidgetState();
}

class _AddOnsRowWidgetState extends State<AddOnsRowWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Padding(
      padding: EdgeInsets.only(
        left: widthMargin * 5,
        right: widthMargin * 5,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: Container(
                width: 20,
                height: 20,
                color: isChecked ? Color(0xff00B7FE) : Color(0xff92959E),
                child: isChecked
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.description,
              style: isChecked
                  ? AppTextStyles.montserrat12SemiboldDark
                  : AppTextStyles.montserrat12SemiboldGrey,
            ),
          ),
          Expanded(child: Container()),
          Text(
            widget.price,
            style: isChecked
                ? AppTextStyles.montserrat12SemiboldDark
                : AppTextStyles.montserrat12SemiboldGrey,
          ),
        ],
      ),
    );
  }
}
