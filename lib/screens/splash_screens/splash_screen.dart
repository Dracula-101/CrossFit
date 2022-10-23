import 'package:crossfit/styles/colors.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../config/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int firstDelay = 1;
  int secondDelay = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: SafeArea(
          child: Column(
            children: [
              AnimationConfiguration.staggeredList(
                position: 0,
                delay: Duration(seconds: firstDelay),
                duration: const Duration(seconds: 2),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: logoImage(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      delay: Duration(seconds: firstDelay),
                      duration: Duration(seconds: firstDelay),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: pageHeader(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    AnimationConfiguration.staggeredList(
                      position: 2,
                      delay: Duration(seconds: firstDelay),
                      duration: Duration(seconds: secondDelay),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: pageBody(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  logoImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/intro_image.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  pageHeader() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to',
            style:
                LightText().lightVeryLargeText.copyWith(color: verylightGrey),
          ),
          Text(
            'Cross Fit',
            style: BoldText().boldVeryLargeText7,
          ),
        ],
      ),
    );
  }

  pageBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          Flexible(
              child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'This is a simple app that will help you to track your fitness progress',
                  style: NormalText().largeText,
                ),
                TextSpan(
                  text: '\nTransform your body with us.',
                  style: LightText().lightSmallText.copyWith(
                        color: verylightGrey,
                      ),
                ),
              ],
            ),
          )),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.introPage);
            },
            icon: Icon(
              size: 30,
              Icons.arrow_forward_ios,
              color: white,
            ),
          )
        ],
      ),
    );
  }
}
