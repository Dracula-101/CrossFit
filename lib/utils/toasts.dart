import 'package:crossfit/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Toasts {}

class SnackBars {
  //sohow snackbar
  static void showSnackBar(
      String? title, String? subtitle, BuildContext context,
      {Color? backgroundColor,
      Color? textColor,
      SnackPosition position = SnackPosition.BOTTOM}) {
    GetSnackBar snackBar = GetSnackBar(
      titleText: Text(
        title!,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        subtitle!,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.black,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      snackPosition: position,
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
    Get.showSnackbar(snackBar);
  }
}
