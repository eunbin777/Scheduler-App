import 'package:flutter/material.dart';

class ChangeViewBtn extends StatefulWidget {
  final String viewType;

  const ChangeViewBtn(this.viewType, {Key? key}) : super(key: key);

  @override
  ChangeViewBtnState createState() => ChangeViewBtnState();
}

class ChangeViewBtnState extends State<ChangeViewBtn> {
  @override
  Widget build(BuildContext context) {
    final String type = widget.viewType;
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final navigator = Navigator.of(context);

    return SizedBox(
      width: 0.15 * width,
      child: TextButton(
        onPressed: () {
          if(type == '주') {

          }
          else {

          }
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          backgroundColor: const Color(0xffd0d0d0),
        ),
        child: Text(
          '$type   ▼',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}