import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPrefs sharedPrefs;

class SharedPrefs {
  SharedPreferences? sharedPreferences;
  SharedPrefs(SharedPreferences preferences) {
    sharedPreferences = preferences;
  }
  Future<bool> setString(String key, String value) async {
    return sharedPreferences!.setString(key, value);
  }

  Future<String> getString(String key) async {
    return sharedPreferences!.getString(key) ?? '';
  }

  //set user details
  Future<bool> setUserDetails(LocalUser user) async {
    return sharedPreferences!.setString('user', jsonEncode(user));
  }

  //get user details
  Future<LocalUser> getUserDetails() async {
    String user = sharedPreferences!.getString('user') ?? '';
    return LocalUser.fromJson(jsonDecode(user));
  }

  Future<bool> setOtherDetails(String gender, String location) async {
    String user = sharedPreferences!.getString('user') ?? '';
    LocalUser userDetails = LocalUser.fromJson(jsonDecode(user));
    userDetails.gender = gender;
    userDetails.location = location;
    return sharedPreferences!.setString('user', jsonEncode(userDetails));
  }

  // get name
  Future<String> getName() async {
    String user = sharedPreferences!.getString('user') ?? '';
    return LocalUser.fromJson(jsonDecode(user)).name;
  }

  // get age
  Future<int> getAge() async {
    String user = sharedPreferences!.getString('user') ?? '';
    return LocalUser.fromJson(jsonDecode(user)).age;
  }

  // get height
  Future<double> getHeight() async {
    String user = sharedPreferences!.getString('user') ?? '';
    return LocalUser.fromJson(jsonDecode(user)).height;
  }

  // get weight
  Future<double> getWeight() async {
    String user = sharedPreferences!.getString('user') ?? '';
    return LocalUser.fromJson(jsonDecode(user)).weight;
  }
}

class LocalUser {
  String name;
  int age;
  double height;
  double weight;
  String? gender;
  String? location;

  LocalUser({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    this.gender,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'location': location,
    };
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      name: map['name'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      gender: map['gender'] ?? '',
      location: map['location'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUser.fromJson(String source) =>
      LocalUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, age: $age, height: $height, weight: $weight)';
  }
}
