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
  Color? textColor,
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
          style: BoldText()
              .boldMediumText
              .copyWith(color: textColor ?? Colors.black)),
    ),
  );
}

Widget chipButton({
  required String text,
  BoxDecoration? decoration,
  TextStyle? textStyle,
}) {
  return FittedBox(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
      child: Text(text,
          style: BoldText().boldSmallText.copyWith(color: Colors.black)),
    ),
  );
}

Widget spacedRow(Widget left, Widget right) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      left,
      right,
    ],
  );
}

Widget spacedText(String left, String right) {
  return spacedRow(
    Text(
      left,
      style: BoldText().boldLargeText,
    ),
    Text(
      right,
      style: NormalText().mediumText,
    ),
  );
}

class NoLoginPage extends StatelessWidget {
  final String title;
  const NoLoginPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: lightGreyContrast,
            ),
            child: Image.asset('assets/images/dark-strava-fitbit.png'),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: NormalText().veryLargeText,
          ),
        ],
      ),
    );
  }
}
