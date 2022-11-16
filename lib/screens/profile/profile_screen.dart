import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/config/routes.dart';
import 'package:crossfit/styles/styles.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            collapsedHeight:
                kToolbarHeight + MediaQuery.of(context).padding.top / 3,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.circleInfo),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                FirebaseAuth.instance.currentUser?.displayName ?? '',
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
                      radius: 61,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(FirebaseAuth
                                .instance.currentUser?.photoURL ??
                            'https://cdn-icons-png.flaticon.com/512/17/17004.png'),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  children: [
                    leftSlideAnimation(
                      position: 0,
                      child: modernCard(
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.dumbbell,
                                color: white,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'Workout\nInfo',
                                style: NormalText().mediumText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(Routes.results);
                        },
                      ),
                    ),
                    rightSlideAnimation(
                      position: 1,
                      child: modernCard(
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                FontAwesomeIcons.bowlRice,
                                color: white,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'Meal\nPlans',
                                style: NormalText().mediumText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                leftSlideAnimation(
                  position: 2,
                  delay: 100,
                  duration: 250,
                  child: modernCard(
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.qrCodePage);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.qrcode,
                                color: white,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'QR Scanner',
                                style: NormalText().mediumText,
                              ),
                            ],
                          ),
                          RotatedBox(
                              quarterTurns: 4,
                              child: Container(
                                color: white,
                                height: 40,
                                width: 1,
                              )),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.barCodePage);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.barcode,
                                  color: white,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                  'Bar Code',
                                  style: NormalText().mediumText,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                rightSlideAnimation(
                  position: 3,
                  delay: 100,
                  duration: 250,
                  child: modernCard(
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.fire,
                          color: white,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          'Calorie Manager',
                          style: NormalText().mediumText,
                        ),
                      ],
                    ),
                    hasRowIcon: true,
                  ),
                ),
                leftSlideAnimation(
                  position: 4,
                  delay: 100,
                  duration: 250,
                  child: modernCard(
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.userCheck,
                          color: white,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          'Profile Info',
                          style: NormalText().mediumText,
                        ),
                      ],
                    ),
                    hasRowIcon: true,
                  ),
                ),
                rightSlideAnimation(
                  position: 5,
                  delay: 100,
                  duration: 250,
                  child: modernCard(
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.android,
                            color: white,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            'App info',
                            style: NormalText().mediumText,
                          ),
                        ],
                      ),
                      hasRowIcon: true, onTap: () {
                    showAboutDialog(context: context);
                  }),
                ),
              ],
            ),
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
