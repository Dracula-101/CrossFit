import 'package:crossfit/screens/home_pages/dashboard.dart';
import 'package:crossfit/screens/home_pages/meal_planner/meal_planner.dart';
import 'package:crossfit/screens/home_pages/third-party/third_party.dart';
import 'package:crossfit/screens/splash_screens/log_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  TabController? tabController;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.dumbbell,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        FontAwesomeIcons.dumbbell,
        color: Colors.white,
      ),
      label: 'Workout',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.bowlFood,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        FontAwesomeIcons.bowlFood,
        color: Colors.white,
      ),
      label: 'Your Meals',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'assets/images/strava-fitbit-icon_unactive.png',
        cacheHeight: 100,
        cacheWidth: 100,
        height: 24,
        width: 24,
      ),
      activeIcon: Image.asset(
        'assets/images/strava-fitbit-icon.png',
        cacheHeight: 100,
        cacheWidth: 100,
        height: 24,
        width: 24,
      ),
      label: 'Strava/Fitbit',
    )
  ];

  List<Widget> pages = const [
    DashBoard(),
    MealPlanner(),
    StravaFitbit(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: ValueListenableBuilder<int>(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  return BottomNavigationBar(
                    currentIndex: value,
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    onTap: (index) {
                      selectedIndex.value = index;
                    },
                    selectedLabelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    items: bottomItems,
                  );
                },
              ),
              body: ValueListenableBuilder<int>(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  return IndexedStack(
                    index: value,
                    children: pages,
                  );
                },
              ),
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
