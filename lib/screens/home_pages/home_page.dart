import 'package:crossfit/config/routes.dart';
import 'package:crossfit/screens/splash_screens/log_in_page.dart';
import 'package:crossfit/styles/colors.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../styles/styles.dart';

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

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CrossFit', style: BoldText().boldVeryLargeText),
                    Text(
                        'Welcome back, ${FirebaseAuth.instance.currentUser!.displayName}',
                        style: LightText().lightNormalText),
                  ],
                ),
              ),
              pinned: true,
              elevation: 4,
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.profile);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Hero(
                      tag: 'profile',
                      child: CircleAvatar(
                        radius: 21,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(FirebaseAuth
                                  .instance.currentUser?.photoURL ??
                              'https://images.unsplash.com/photo-1610000000000-000000000000?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextField(
                    decoration:
                        inputDecoration('Search', Icons.search_rounded, null),
                  ),
                ),
                expandedTitleScale: 1,
                background: Container(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.07),
                  child: Text(
                    'Discover how to shape you body',
                    style: BoldText().boldVeryLargeText4,
                  ),
                ),
              ),
              collapsedHeight: MediaQuery.of(context).size.height * 0.15,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            SliverAnimatedList(
              initialItemCount: 20,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).chain(
                      CurveTween(
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('Item $index'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DashBoardHeader extends SliverPersistentHeaderDelegate {
  getHeaderString() {
    DateTime time = DateTime.now();
    if (time.hour >= 4 && time.hour < 12) {
      return 'Good Morning';
    } else if (time.hour >= 12 && time.hour < 16) {
      return 'Good Afternoon';
    } else if (time.hour >= 16 && time.hour < 20) {
      return 'Good Evening';
    } else {
      return 'Night';
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: shrinkOffset != 0
          ? BoxDecoration(color: darkGrey, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ])
          : null,
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                'Discover how to shape your body',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40 - (shrinkOffset / 10),
                ),
              ),
            ),
            //firebase user image
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(FirebaseAuth
                        .instance.currentUser?.photoURL ??
                    'https://images.unsplash.com/photo-1610000000000-000000000000?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
