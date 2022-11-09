import 'package:crossfit/api/constants.dart';
import 'package:crossfit/models/meal_planner/meal_plans.model.dart';
import '../../services/api_mangament.dart';

class MealPlannerApi {
  static Future<MealTemplateDay> getDayMealPlan(
      String targetCalories, String timeFrame,
      {String diet = 'vegetarian'}) async {
    ApiRequest<MealTemplateDay> apiRequest = ApiRequest(
      baseUrl: MealPlanner.baseUrl,
      path: MealPlanner.generateMealPlan,
      headers: MealPlanner.headers,
      queryParameters: {
        'targetCalories': targetCalories,
        'timeFrame': timeFrame,
        'diet': diet,
        'apiKey': MealPlanner.apiKey.first,
      },
      method: ApiTypes.GET,
    );
    final response = await apiRequest.execute();
    MealTemplateDay mealTemplate = MealTemplateDay.fromJson(response);
    return mealTemplate;
  }

  static Future<MealTemplateWeek>? getMealWeek(
      String targetCalories, String timeFrame,
      {String diet = "vegetarian"}) async {
    ApiRequest<MealTemplateWeek> apiRequest = ApiRequest(
      baseUrl: MealPlanner.baseUrl,
      path: MealPlanner.generateMealPlan,
      headers: MealPlanner.headers,
      queryParameters: {
        'targetCalories': targetCalories,
        'timeFrame': timeFrame,
        'diet': diet,
        'apiKey': MealPlanner.apiKey.first,
      },
      method: ApiTypes.GET,
    );
    final response = await apiRequest.execute();
    MealTemplateWeek mealTemplate = MealTemplateWeek.fromJson(response);
    return mealTemplate;
  }
}
