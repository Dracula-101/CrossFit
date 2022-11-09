import 'dart:async';

import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';

class LocalStorageManager {
  static const String _kTokenKey = "fitbit_token";
  // static String _kScopesKey = "strava_scopes";
  //save token
  static Future<bool> saveToken(String token) async {
    return sharedPrefs.setString(_kTokenKey, token);
  }

  //delete token
  static Future<bool> deleteToken({String applicationName = ""}) async {
    await Future.wait([
      sharedPrefs.sharedPreferences!.remove("userId"),
      sharedPrefs.sharedPreferences!.remove(_kTokenKey),
      sharedPrefs.sharedPreferences!.remove("refreshToken"),
    ]);
    return true;
  }

  static Future<bool> saveDetails(
      String userId, String accessToken, String refreshToken) async {
    final result = await Future.wait([
      sharedPrefs.setString("userId", userId),
      sharedPrefs.setString(_kTokenKey, accessToken),
      sharedPrefs.setString("refreshToken", refreshToken),
    ]);
    return result[0] && result[1] && result[2];
  }

  static Future<List<String>> getDetails() async {
    final result = await Future.wait([
      sharedPrefs.getString("userId"),
      sharedPrefs.getString(_kTokenKey),
      sharedPrefs.getString("refreshToken"),
    ]);
    return result;
  }

  //get token
  static Future<String?> getToken() async {
    String? tokenJson = await sharedPrefs.getString(_kTokenKey);
    return tokenJson;
  }
}
