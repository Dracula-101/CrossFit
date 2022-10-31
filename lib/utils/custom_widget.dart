import 'package:crossfit/styles/colors.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget modernCard(Widget child,
        {EdgeInsets margin =
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        EdgeInsets padding = const EdgeInsets.all(20),
        Function? onTap,
        bool hasRowIcon = false}) =>
    GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: black,
              blurRadius: 7,
              offset: const Offset(2, 2),
              spreadRadius: 4,
            ),
            BoxShadow(
              color: darkGreyContrast,
              blurRadius: 7,
              spreadRadius: 2,
              offset: const Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: white.withOpacity(0.2),
            width: 2,
          ),
        ),
        margin: margin,
        padding: padding,
        child: rowAddition(
            child: child,
            additionWidget: const Icon(FontAwesomeIcons.chevronRight),
            hasRow: hasRowIcon),
      ),
    );

Widget rowAddition(
    {required Widget child, required Widget additionWidget, required hasRow}) {
  return hasRow
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
            additionWidget,
          ],
        )
      : child;
}

Widget wideButton({
  required String text,
  required Function onPressed,
  required BuildContext context,
  BoxDecoration? decoration,
}) {
  return InkWell(
    onTap: onPressed as void Function()?,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      // height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
      child: Text(text,
          style: BoldText().boldMediumText.copyWith(color: Colors.black)),
    ),
  );
}
