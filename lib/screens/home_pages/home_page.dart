import 'package:crossfit/screens/home_pages/dashboard.dart';
import 'package:crossfit/screens/splash_screens/log_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  
  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
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
    BottomNavigationBarItem(
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
      icon: Icon(
        FontAwesomeIcons.user,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        FontAwesomeIcons.user,
        color: Colors.white,
      ),
      label: 'Profile',
    ),
  ];

  List<Widget> pages = const [
    DashBoard(),
    Center(
      child: Text('Your Meals'),
    ),
    Center(
      child: Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: ValueListenableBuilder<int>(
                valueListenable: _selectedIndex,
                builder: (context, value, child) {
                  return BottomNavigationBar(
                    currentIndex: value,
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    onTap: (index) {
                      _selectedIndex.value = index;
                    },
                    selectedLabelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    items: bottomItems,
                  );
                },
              ),
              body: ValueListenableBuilder<int>(
                valueListenable: _selectedIndex,
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
