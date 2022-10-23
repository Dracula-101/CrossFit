import 'package:crossfit/config/routes.dart';
import 'package:crossfit/styles/themes.dart';
import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = SharedPrefs(await SharedPreferences.getInstance());
  await Firebase.initializeApp();
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
      initialRoute: FirebaseAuth.instance.currentUser!=null?Routes.homePage: initialRoute,
      themeMode: ThemeMode.dark,

    );
  }
}
