import 'package:crossfit/models/workout/exercise.model.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:crossfit/utils/components/Section.dart';
import 'package:crossfit/utils/components/daily_tip.dart';
import 'package:crossfit/utils/components/image_card_with_basic_footer.dart';
import 'package:crossfit/utils/components/image_card_with_internal.dart';
import 'package:crossfit/utils/components/main_card_programs.dart';
import 'package:flutter/material.dart';

class Programs extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      image: 'assets/images/exercise/image001.jpg',
      title: 'Easy Start',
      time: '5 min',
      difficult: 'Low',
    ),
    Exercise(
      image: 'assets/images/exercise/image002.jpg',
      title: 'Medium Start',
      time: '10 min',
      difficult: 'Medium',
    ),
    Exercise(
      image: 'assets/images/exercise/image003.jpg',
      title: 'Pro Start',
      time: '25 min',
      difficult: 'High',
    )
  ];

  Programs({super.key});

  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    int count = 0;
    exercises.forEach((exercise) {
      Widget element = Container(
        margin: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: ImageCardWithBasicFooter(
            exercise: exercise,
            tag: 'imageHeader$count',
            imageWidth: 160.0,
          ),
          onTap: () {},
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Programs',
                  style: BoldText().boldVeryLargeText1,
                ),
              ),
              MainCardPrograms(), // MainCard
              Section(
                title: 'Fat burning',
                horizontalList: generateList(context),
              ),
              const Section(
                title: 'Abs Generating',
                horizontalList: <Widget>[
                  ImageCardWithInternal(
                    image: 'assets/images/exercise/image004.jpg',
                    title: 'Core \nWorkout',
                    duration: '7 min',
                  ),
                  ImageCardWithInternal(
                    image: 'assets/images/exercise/image004.jpg',
                    title: 'Core \nWorkout',
                    duration: '7 min',
                  ),
                  ImageCardWithInternal(
                    image: 'assets/images/exercise/image004.jpg',
                    title: 'Core \nWorkout',
                    duration: '7 min',
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Section(
                  horizontalList: <Widget>[
                    DailyTip(),
                    DailyTip(),
                    DailyTip(),
                  ],
                  title: '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
