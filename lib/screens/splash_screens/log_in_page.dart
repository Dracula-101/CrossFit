import 'package:crossfit/config/routes.dart';
import 'package:crossfit/services/auth.dart';
import 'package:crossfit/styles/styles.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final int delay = 250;
  User? signedInUser;
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          loading.value = true;
          FocusScope.of(context).unfocus();
          if (signedInUser?.email != null) {
            // user is already signed in

          } else {
            signedInUser =
                await Authentication.signInWithGoogle(context: context);
            if (!(await sharedPrefs.getBool('firstLogin'))) {
              await sharedPrefs.setBool('firstLogin', false);
            }
            if (signedInUser != null) {
              Get.offAllNamed(Routes.homePage);
            }
          }
          loading.value = false;
        },
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, child) {
                if (value) {
                  return const CircularProgressIndicator();
                } else {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        FontAwesomeIcons.google,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Log in with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
              },
            )),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimationConfiguration.staggeredList(
                  position: 0,
                  delay: Duration(milliseconds: delay * 3),
                  duration: Duration(milliseconds: delay),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CrossFit',
                                  style: BoldText().boldVeryLargeText6),
                              Text(
                                'An App for maintaining your fitness. Find your perfect routine and manage your progress.',
                                style: LightText().lightVeryLargeText,
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimationConfiguration.staggeredList(
                          position: 1,
                          delay: Duration(milliseconds: delay),
                          duration: Duration(milliseconds: delay),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: modernCard(
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/images/exercise.png',
                                      height: 79,
                                      width: 79,
                                      cacheHeight: 300,
                                      cacheWidth: 300,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Manage your Exercise',
                                      style: LightText().lightMediumText,
                                    )
                                  ]),
                                ),
                                padding: const EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ),
                        AnimationConfiguration.staggeredList(
                          position: 2,
                          delay: Duration(milliseconds: delay),
                          duration: Duration(milliseconds: delay),
                          child: SlideAnimation(
                            verticalOffset: 30.0,
                            child: FadeInAnimation(
                              child: modernCard(
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    child: Column(children: [
                                      Image.asset(
                                        'assets/images/meal.png',
                                        height: 79,
                                        width: 79,
                                        cacheHeight: 300,
                                        cacheWidth: 300,
                                        filterQuality: FilterQuality.high,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Plan your diet',
                                        style: LightText().lightMediumText,
                                      )
                                    ]),
                                  ),
                                  padding: const EdgeInsets.all(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimationConfiguration.staggeredList(
                          position: 3,
                          delay: Duration(milliseconds: delay),
                          duration: Duration(milliseconds: delay),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: modernCard(
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/images/metabolism.png',
                                      height: 79,
                                      width: 79,
                                      cacheHeight: 300,
                                      cacheWidth: 300,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Track your progress',
                                      style: LightText().lightMediumText,
                                    )
                                  ]),
                                ),
                                padding: const EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ),
                        AnimationConfiguration.staggeredList(
                          position: 4,
                          delay: Duration(milliseconds: delay),
                          duration: Duration(milliseconds: delay),
                          child: SlideAnimation(
                            verticalOffset: 30.0,
                            child: FadeInAnimation(
                              child: modernCard(
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    child: Column(children: [
                                      Image.asset(
                                        'assets/images/dark-strava-fitbit.png',
                                        height: 79,
                                        width: 79,
                                        cacheHeight: 300,
                                        cacheWidth: 300,
                                        filterQuality: FilterQuality.high,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Strava/Fitbit\nIntegration',
                                        style: LightText().lightMediumText,
                                      )
                                    ]),
                                  ),
                                  padding: const EdgeInsets.all(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AnimationConfiguration.staggeredList(
                  position: 1,
                  delay: Duration(milliseconds: delay),
                  duration: Duration(milliseconds: delay),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get Started',
                            style: BoldText().boldLargeText,
                          ),
                          Text(
                            'Sign up with google to start your fitness journey',
                            style: LightText().lightNormalText,
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
