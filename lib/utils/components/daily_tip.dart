import 'package:crossfit/styles/colors.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:flutter/material.dart';

class DailyTip extends StatelessWidget {
  final Map<String, String> element = {
    'title': '3 Main workout tips',
    'subtitle':
        'The American Council on Exercises (ACE) recently surveyed 3,000 ACE-certificated personal trainers about the best!',
    'image': 'assets/images/exercise/image011.jpg',
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.80;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: width,
          height: MediaQuery.of(context).size.height * 0.25,
          margin: const EdgeInsets.only(
            right: 15.0,
            bottom: 10.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(element['image'] ?? ''),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
        Text(
          element['title'] ?? '',
          style: BoldText().boldNormalText,
        ),
        Container(
          width: width,
          margin: const EdgeInsets.only(top: 10.0),
          child: Text(
            element['subtitle'] ?? '',
            style: NormalText().smallText.copyWith(color: dullWhite),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 15.0,
          ),
          child: const Text(
            'More',
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: Colors.lightBlue,
          ),
        ),
      ],
    );
  }
}
