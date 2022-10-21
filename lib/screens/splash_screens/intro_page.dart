import 'package:crossfit/styles/colors.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/route_manager.dart';
import 'package:intro_slider/intro_slider.dart';

import '../../config/routes.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IntroSlider(
        renderNextBtn: Row(
          children: const [
            Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
        renderPrevBtn: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        renderDoneBtn: GestureDetector(
          onTap: () {
            Get.offAllNamed(Routes.profileSetup);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.done_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
        renderSkipBtn: const Text(
          'Skip',
          style: TextStyle(color: Colors.white),
        ),
        indicatorConfig: IndicatorConfig(
          colorActiveIndicator: white,
        ),
        listCustomTabs: const [
          WorkoutInfoPage(),
          MealPlannerInfo(),
          CalorieInfo(),
          QrCodeInfo(),
        ],
      )),
    );
  }
}

class WorkoutInfoPage extends StatelessWidget {
  final int delay = 500;
  const WorkoutInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AnimationConfiguration.staggeredList(
            position: 0,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/exercise.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimationConfiguration.staggeredList(
            position: 1,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Manage your workout',
                    style: BoldText()
                        .boldVeryLargeText2
                        .copyWith(color: lightWhite),
                  ),
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Find the best workout for you. \nCrossfit is the best way to get fit',
                    style:
                        LightText().lightMediumText.copyWith(color: dullWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealPlannerInfo extends StatelessWidget {
  const MealPlannerInfo({super.key});
  final int delay = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AnimationConfiguration.staggeredList(
            position: 0,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/meal.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimationConfiguration.staggeredList(
            position: 1,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Plan your meals',
                    style: BoldText()
                        .boldVeryLargeText2
                        .copyWith(color: lightWhite),
                  ),
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Choose through our wide range of meal plans and get started.\nYou can also create your own meal plan',
                    style:
                        LightText().lightMediumText.copyWith(color: dullWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalorieInfo extends StatelessWidget {
  const CalorieInfo({super.key});
  final int delay = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AnimationConfiguration.staggeredList(
            position: 0,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/metabolism.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimationConfiguration.staggeredList(
            position: 1,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Calorie Management System',
                    style: BoldText()
                        .boldVeryLargeText2
                        .copyWith(color: lightWhite),
                  ),
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Our calorie management system will help you to keep track of your calories and help you to reach your goal\nSee your progress and get motivated',
                    style:
                        LightText().lightMediumText.copyWith(color: dullWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QrCodeInfo extends StatelessWidget {
  const QrCodeInfo({super.key});
  final int delay = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AnimationConfiguration.staggeredList(
            position: 0,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/qr-code.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimationConfiguration.staggeredList(
            position: 1,
            delay: Duration(milliseconds: delay),
            duration: Duration(milliseconds: delay),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'QR Code Scanner',
                    style: BoldText()
                        .boldVeryLargeText2
                        .copyWith(color: lightWhite),
                  ),
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Scan the QR code on your food and get the nutrition facts\nYou can also find a detailed view of all the macros present inside the food',
                    style:
                        LightText().lightMediumText.copyWith(color: dullWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
