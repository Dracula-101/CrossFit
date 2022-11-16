import 'dart:convert';

import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';


class MealPlannerSaver {
  static const String _mealPlannerKey = 'meal_planner';
  static const String _mealPlannerListKey = 'meal_planner_list';
  static const String userDetails = 'user_details';

  //save user hash and id
  static Future<void> saveMealPlanner(String userId, String userHash) async {
    //encode into json
    final mealPlanner = MealUserDetails(userId: userId, userHash: userHash);
    final mealPlannerJson = mealPlanner.toJson();
    //save to shared prefs
    await sharedPrefs.setString(userDetails, jsonEncode(mealPlannerJson));
  }

  //get user hash and id
  static Future<MealUserDetails?> getMealPlanner() async {
    final mealPlannerJson = await sharedPrefs.getString(userDetails);
    return mealPlannerJson != ""
        ? MealUserDetails.fromJson(jsonDecode(mealPlannerJson))
        : MealUserDetails(userId: '', userHash: '');
  }

  static Future<bool> hasMealPlan() async {
    final mealPlannerJson = await sharedPrefs.getString(userDetails);
    return MealUserDetails.fromJson(jsonDecode(mealPlannerJson)).userHash != '';
  }

  //save meal planner
}

class MealUserDetails {
  String userId, userHash;

  MealUserDetails({required this.userId, required this.userHash});

  factory MealUserDetails.fromJson(Map<String, dynamic> json) {
    return MealUserDetails(
      userId: json['userId'],
      userHash: json['userHash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userHash': userHash,
    };
  }
}
