// define routes
import 'package:crossfit/screens/home_pages/home_page.dart';
import 'package:crossfit/screens/profile/profile_screen.dart';
import 'package:crossfit/screens/profile_setup.dart/profile_setup.dart';
import 'package:crossfit/screens/splash_screens/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:crossfit/screens/splash_screens/intro_page.dart';
import '../screens/splash_screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashScreen(),
  '/intro': (context) => const IntroPage(),
  '/profile_setup': (context) => const ProfileSetup(),
  '/home': (context) => const MyHomePage(),
  '/profile': (context) => const ProfileScreen(),
  '/login': (context) => const LoginScreen(),
};
String initialRoute = '/';

class Routes {
  static const String splashScreen = '/';
  static const String introPage = '/intro';
  static const String homePage = '/home';
  static const String profileSetup = '/profile_setup';
  static const String profile = '/profile';
  static const String login = '/login';
}
