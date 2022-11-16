// define routes
import 'package:crossfit/screens/home_pages/dashboard/Results.dart';
import 'package:crossfit/screens/home_pages/home_page.dart';
import 'package:crossfit/screens/home_pages/third-party/fitbit_page.dart';
import 'package:crossfit/screens/home_pages/third-party/strava_page.dart';
import 'package:crossfit/screens/profile/profile_screen.dart';
import 'package:crossfit/screens/scanner/bar_code_scanner.dart';
import 'package:crossfit/screens/splash_screens/profile_setup.dart/profile_setup.dart';
import 'package:crossfit/screens/scanner/qr_scanner.dart';
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
  '/qrcode': (context) => const QrCodeScanner(),
  '/barcode': (context) => const BarCodeScanner(),
  '/strava': (context) => const StravaPage(),
  '/fitbit': (context) => const FitbitPage(),
  '/results': (context) => const Results(),
};
String initialRoute = '/';

class Routes {
  static const String splashScreen = '/';
  static const String introPage = '/intro';
  static const String homePage = '/home';
  static const String profileSetup = '/profile_setup';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String qrCodePage = '/qrcode';
  static const String barCodePage = '/barcode';
  static const String strava = '/strava';
  static const String fitbit = '/fitbit';
  static const String results = '/results';
}

Map<String, Widget Function(BuildContext)> testRoutes = {
  '/': (context) => const IntroPage(),
  '/profile_setup': (context) => const ProfileSetup(),
};
