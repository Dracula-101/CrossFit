import 'package:crossfit/styles/colors.dart';
import 'package:flutter/material.dart';

Widget modernCard(Widget child,
        {EdgeInsets margin =
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        EdgeInsets padding = const EdgeInsets.all(20)}) =>
    Container(
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
      child: child,
    );
