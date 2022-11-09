import 'package:crossfit/api/constants.dart';
import 'package:crossfit/models/meal_planner/meal_plans.model.dart';
import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class MealPlannerCard extends StatefulWidget {
  final Meals meal;
  const MealPlannerCard({super.key, required this.meal});

  @override
  State<MealPlannerCard> createState() => _MealPlannerCardState();
}

class _MealPlannerCardState extends State<MealPlannerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black54,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              MealPlanner.imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 0.3,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no-image.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.height * 0.3,
                  height: MediaQuery.of(context).size.height * 0.25,
                );
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
              child: Text(
                widget.meal.title ?? 'No title',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealPlannerWeekCard extends StatefulWidget {
  final Meals meal;
  final int index;
  const MealPlannerWeekCard(
      {super.key, required this.meal, required this.index});

  @override
  State<MealPlannerWeekCard> createState() => _MealPlannerWeekCardState();
}

class _MealPlannerWeekCardState extends State<MealPlannerWeekCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black54,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              MealPlanner.imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no-image.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                );
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                padding:
                    const EdgeInsets.only(right: 5, bottom: 2, top: 2, left: 7),
                child: Text(
                  getDay(widget.index),
                )),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
              child: Text(
                widget.meal.title ?? 'No title',
                style: NormalText().smallerText,
              ),
            ),
          ),
        ],
      ),
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
