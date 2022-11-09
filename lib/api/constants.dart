class APIConstants {
  static const String WORKOUT_URL = "https://api.api-ninjas.com/v1/";
  static const String API_KEY = "dlmcdPkOyx0zQuiothtf8A==vIdEeUH4X2NkuCJ5";

  //workout categories
  static const String exercises = "exercises";

  static const List<String> muscleGroups = [
    "abdominals",
    "abductors",
    "adductors",
    "biceps",
    "calves",
    "chest",
    "forearms",
    "glutes",
    "hamstrings",
    "lats",
    "lower_back",
    "middle_back",
    "neck",
    "quadriceps",
    "traps",
    "triceps",
  ];

  static const List<String> difficulty = [
    "beginner",
    "intermediate",
    "expert",
  ];
}

class MealPlanner {
  static const String baseUrl = "https://api.spoonacular.com";
  static const String imageUrl =
      "https://spoonacular.com/cdn/ingredients_250x250/";
  static List<String> apiKey = [
    "058fbfc698bd46d285d6e5f92ab16399",
    "3c3fa0f6ee414e9c8792a700087d1118",
    "d9ec84e453654268984a928a88645819",
    "92741f886d064d45808dfbd157c066c1",
    "d8905056f5f34351bf953b33a8964733",
    "d8856840f0b443d6b3d0d19dec1dfd27"
  ];

  static String connectUser = "/users/connect";
}

class Strava {
  static const String clientId = "93450";
  static const String clientSecret = "dc0725bae2d83fa42f3bdb11bc9acc7f9470a9f4";
  static const String redirectUrl = 'crossfit://strava';
}

class Fitbit {
  static const String clientId = "238VSW";
  static const String clientSecret = "125b296cc60aed88a9beed8d28cb3756";
  static const String redirectUrl = 'crossfit://fitbit';
  static const String callbackUrlScheme = 'crossfit';
  static String baseUrl(String? userId) =>
      'https://api.fitbit.com/1/user/$userId';
}
