import 'package:crossfit/config/routes.dart';
import 'package:crossfit/styles/styles.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: MediaQuery.of(context).size.height * 0.07,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.circleInfo),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${FirebaseAuth.instance.currentUser!.displayName}',
              ),
              centerTitle: true,
              background: Container(
                color: Colors.black54,
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Hero(
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      return toHeroContext.widget;
                    },
                    tag: 'profile',
                    child: CircleAvatar(
                      radius: 81,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(FirebaseAuth
                                .instance.currentUser?.photoURL ??
                            'https://images.unsplash.com/photo-1610000000000-000000000000?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          SliverAnimatedList(
            initialItemCount: 10,
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
                  child: modernCard(Text('${index}')));
            },
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.rightFromBracket,
                              color: white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Logout'),
                          ],
                        ),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: LightText()
                                    .lightMediumText
                                    .copyWith(color: white),
                              )),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Get.offAllNamed(Routes.login);
                              },
                              child: Text('Logout',
                                  style: LightText().lightMediumText.copyWith(
                                        color: white,
                                      ))),
                        ],
                      );
                    });
              },
              child: Container(
                height: 100,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
