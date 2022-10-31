import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:crossfit/api/constants.dart';
import 'package:crossfit/models/meal_planner/user.model.dart';
import 'package:crossfit/services/api_mangament.dart';
import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserApi {
  static Future<UserModel?> connectUser() async {
    LocalUser localUser = await sharedPrefs.getUserDetails();
    String userName = localUser.name + localUser.age.toString();
    String firstName = localUser.name.split(' ')[0];
    String lastName;
    try {
      lastName = localUser.name.split(' ')[1];
    } catch (e) {
      lastName = " ";
    }
    String email = FirebaseAuth.instance.currentUser!.email ?? '';
    Map<String, dynamic> body = {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
    };
    final requestBody = jsonEncode(body);
    Map<String, String> headers = {
      'x-api-key': MealPlanner.apiKey.first,
      // 'Content-Type': 'application/json',
    };
    ApiRequest<UserModel> apiRequest = ApiRequest(
      baseUrl: MealPlanner.baseUrl,
      path: MealPlanner.connectUser,
      headers: headers,
      body: requestBody,
      method: ApiTypes.POST,
    );
    UserModel? userModel = UserModel.fromJson(await apiRequest.execute());
    return userModel;
  }
}
