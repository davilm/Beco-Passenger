import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData icon;
  String trip;
  final List cityList;
  final Function onChoosedRoute;

  TextFieldWidget(
    this.icon,
    this.trip,
    this.cityList, {
    required this.onChoosedRoute,
    Key? key,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    final generalWidth = MediaQuery.of(context).size.width;
    final double fieldButtonHeight = 60;

    return Padding(
      padding: EdgeInsets.only(
        left: widthMargin * 5,
        right: widthMargin * 5,
        bottom: 10,
      ),
      child: Container(
        height: fieldButtonHeight,
        width: generalWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffD0D2DA),
            width: 1,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Icon(
                widget.icon,
                color: Color(0xff15192C),
                size: 30.0,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: DropdownButton(
                underline: Container(color: Colors.transparent),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.transparent,
                ),
                items: widget.cityList.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                hint: Text(
                  widget.trip,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff92959E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: (city) {
                  setState(() {
                    widget.trip = city.toString();
                    widget.onChoosedRoute(widget.trip);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
