import 'package:crossfit/styles/font_style.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget? rightSide;

  const Header(this.title, {super.key, required this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20.0),
          height: 54.0,
          child: Text(
            title,
            style: BoldText().boldVeryLargeText2,
          ),
        ),
        (rightSide != null) ? rightSide! : Container()
      ],
    );
  }
}
