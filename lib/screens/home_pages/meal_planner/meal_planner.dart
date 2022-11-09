import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/api/meal_planner/generate_meal_plan.dart';
import 'package:crossfit/api/meal_planner/user.api.dart';
import 'package:crossfit/models/meal_planner/meal_plans.model.dart';
import 'package:crossfit/screens/home_pages/meal_planner/meal_planner_card.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:crossfit/utils/shared_preferences/meal_planer_saver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../styles/styles.dart';

class MealPlannerPage extends StatefulWidget {
  const MealPlannerPage({super.key});

  @override
  State<MealPlannerPage> createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  Future<MealUserDetails?>? userDetails;
  bool hasMealPlans = false;
  @override
  void initState() {
    super.initState();
    userDetails = MealPlannerSaver.getMealPlanner().then((value) {
      if (value?.userHash != "") {
        setState(() {
          hasMealPlans = true;
        });
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding:
                        const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                    background: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(
                          FontAwesomeIcons.bowlFood,
                          size: 100,
                          color: darkGreyContrast,
                        ),
                      ),
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Your Meals',
                          style: BoldText().boldLargeText,
                          children: <TextSpan>[
                            TextSpan(
                              text: '\nFind your meals',
                              style: NormalText().smallText,
                            )
                          ],
                        ),
                      ),
                    ),
                    expandedTitleScale: 1.5,
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  floating: false,
                  pinned: true,
                  primary: true,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<MealUserDetails?>(
                future: userDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (!hasMealPlans) {
                      return NoMealWidget(onPressed: () {
                        setState(() {
                          hasMealPlans = true;
                        });
                      });
                    }
                    return const MealPlannerWidget();
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      )),
    );
  }
}

class NoMealWidget extends StatefulWidget {
  final VoidCallback onPressed;
  const NoMealWidget({super.key, required this.onPressed});

  @override
  State<NoMealWidget> createState() => _NoMealWidgetState();
}

class _NoMealWidgetState extends State<NoMealWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return verticalAnimation(
      position: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.burger,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Meal Planner not configured yet',
              style: NormalText().mediumText,
            ),
            const SizedBox(height: 20),
            !isLoading
                ? wideButton(
                    text: 'Configure',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final userDetails = await UserApi.connectUser();
                      if (userDetails != null) {
                        await MealPlannerSaver.saveMealPlanner(
                            userDetails.hash ?? '', userDetails.username ?? '');
                        widget.onPressed();
                      }
                    },
                    context: context)
                : const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
          ],
        ),
      ),
    );
  }
}

class MealPlannerWidget extends StatefulWidget {
  const MealPlannerWidget({super.key});

  @override
  State<MealPlannerWidget> createState() => _MealPlannerWidgetState();
}

class _MealPlannerWidgetState extends State<MealPlannerWidget> {
  Future<MealTemplateDay>? mealDay;
  Future<MealTemplateWeek>? mealWeek;

  @override
  void initState() {
    super.initState();
    mealDay = MealPlannerApi.getDayMealPlan('2000', 'day');
    mealWeek = MealPlannerApi.getMealWeek('2000', 'week');
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        FutureBuilder(
          future: MealPlannerApi.getDayMealPlan('2000', 'day'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meal Plans for 2000 Calories',
                      style: BoldText().boldMediumText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.meals?.length ?? 0,
                        itemBuilder: (context, index) {
                          return MealPlannerCard(
                            meal: snapshot.data!.meals![index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const SliverToBoxAdapter(child: Text('Error'));
            } else {
              return const SliverFillRemaining(
                  child: Center(
                      child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              )));
            }
          },
        ),
        SliverToBoxAdapter(
          child: FutureBuilder(
            future: mealWeek,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 2),
                  child: Text(
                    'Week meal plans',
                    style: BoldText().boldMediumText,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        FutureBuilder(
          future: mealWeek,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return MealPlannerWeekCard(
                      meal: snapshot.data!.week!.days![index].meals![0],
                      index: index,
                    );
                  },
                  childCount: snapshot.data?.week?.days?.length ?? 0,
                ),
              );
            } else if (snapshot.hasError) {
              return const SliverToBoxAdapter(child: Text('Error'));
            } else {
              return const SliverFillRemaining(
                child: SizedBox(),
              );
            }
          },
        )
      ],
    );
  }

  String getDay(int index) {
    switch (index) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }
}
