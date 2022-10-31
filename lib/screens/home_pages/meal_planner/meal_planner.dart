import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/api/meal_planner/user.api.dart';
import 'package:crossfit/models/meal_planner/user.model.dart';
import 'package:crossfit/styles/font_style.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealPlanner extends StatefulWidget {
  const MealPlanner({super.key});

  @override
  State<MealPlanner> createState() => _MealPlannerState();
}

class _MealPlannerState extends State<MealPlanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: Text('Your Meals'),
            ),
            SliverToBoxAdapter(child: NoMealWidget(onPressed: () {})
                // Column(children: [
                //   FutureBuilder<UserModel?>(
                //     future: UserApi.connectUser(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return Column(
                //           children: [
                //             Text(snapshot.data?.username ?? ''),
                //             Text(snapshot.data?.spoonacularPassword ?? ''),
                //             Text(snapshot.data?.hash ?? ''),
                //           ],
                //         );
                //       } else {
                //         return const CircularProgressIndicator();
                //       }
                //     },
                //   )
                // ]),
                )
          ],
        ),
      ),
    );
  }
}

class NoMealWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const NoMealWidget({super.key, required this.onPressed});

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
            Icon(
              FontAwesomeIcons.burger,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Meal Planner not configured yet',
              style: NormalText().mediumText,
            ),
            SizedBox(height: 20),
            wideButton(text: 'Configure', onPressed: () {}, context: context)
          ],
        ),
      ),
    );
  }
}
