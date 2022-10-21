import 'package:crossfit/config/routes.dart';
import 'package:crossfit/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cross Fit',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      routes: routes,
      themeMode: ThemeMode.dark,

    );
  }
}
