// ignore_for_file: subtype_of_sealed_class, must_be_immutable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossfit/api/constants.dart';
import 'package:crossfit/api/workout/workout_api.dart';
import 'package:crossfit/models/meal_planner/meal_plans.model.dart';
import 'package:crossfit/models/workout/exercise.model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  MockFirestore instance = MockFirestore();
  MockDocumentSnapshot mockDocumentSnapshot = MockDocumentSnapshot();
  MockCollectionReference mockCollectionReference = MockCollectionReference();
  MockDocumentReference mockDocumentReference = MockDocumentReference();
  Logger logs = Logger();

  group('Testing API call:', () {
    test(' Day Meal Planner', () async {
      //api call
      final url = Uri.parse(MealPlanner.baseUrl + MealPlanner.generateMealPlan);
      final response = await http.get(url, headers: MealPlanner.headers);
      MealTemplateDay mealTemplate =
          MealTemplateDay.fromJson(jsonDecode(response.body));
      // logs.i(mealTemplate);
      expect(
        mealTemplate,
        isA<MealTemplateDay>(),
        reason: 'The response should be a MealTemplateDay object',
      );
    });

    test(' Week Meal Planner', () async {
      //api call
      final url = Uri.parse(MealPlanner.baseUrl + MealPlanner.generateMealPlan);
      final response = await http.get(url, headers: MealPlanner.headers);
      MealTemplateWeek mealTemplate =
          MealTemplateWeek.fromJson(jsonDecode(response.body));
      // logs.i(mealTemplate);
      expect(
        mealTemplate,
        isA<MealTemplateWeek>(),
        reason: 'The response should be a MealTemplateWeek object',
      );
    });

    test(' Workout List', () async {
      //api call
      final url = Uri.parse(WorkoutAPI.baseUrl + WorkoutAPI.exercise);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${WorkoutAPI.apiKey}'
      };
      var response = await http.get(url, headers: headers);
      expect(
        response.statusCode,
        200,
        reason: 'The response should be a 200',
      );
    });
  });

  group('Firebase Database Storage', () {
    late MealTemplateDay mealTemplate;
    late Workouts workoutTemplate;
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    late CollectionReference mockCollectionReference;
    setUp(() {
      mealTemplate = MealTemplateDay.fromJson(jsonDecode(mealdayJson));
      workoutTemplate = Workouts.fromJson(jsonDecode(workoutJson));
    });

    test('Check Storing Meal plan', () async {
      mockCollectionReference = fakeFirebaseFirestore.collection('meals');
      await mockCollectionReference.add(mealTemplate.toJson());
      QuerySnapshot<Object?> querySnapshot =
          await mockCollectionReference.get();
      //get the data from the collection
      List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;
      //get the first document
      QueryDocumentSnapshot<Object?> document = documents.first;
      //get the data from the document
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      //check if the data is the same as the one we added
      expect(data, mealTemplate.toJson());
    });

    test('Check Storing Workout Plan', () async {
      mockCollectionReference = fakeFirebaseFirestore.collection('workouts');
      await mockCollectionReference.add(workoutTemplate.toJson());
      QuerySnapshot<Object?> querySnapshot =
          await mockCollectionReference.get();
      //get the data from the collection
      List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;
      //get the first document
      QueryDocumentSnapshot<Object?> document = documents.first;
      //get the data from the document
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      //check if the data is the same as the one we added
      expect(data, workoutTemplate.toJson());
    });

    //
  });
}

String mealdayJson =
    """{"meals":[{"id":646340,"imageType":"jpg","title":"Hatch Chile Cornbread Muffins","readyInMinutes":45,"servings":12,"sourceUrl":"https://spoonacular.com/hatch-chile-cornbread-muffins-646340"},{"id":241060,"imageType":"jpg","title":"Portobello Sandwiches","readyInMinutes":14,"servings":4,"sourceUrl":"http://www.myrecipes.com/recipe/portobello-sandwiches-50400000126824/"},{"id":188826,"imageType":"jpg","title":"Oyster-Cornbread Stuffing","readyInMinutes":45,"servings":10,"sourceUrl":"http://www.epicurious.com/recipes/food/views/Oyster-Cornbread-Stuffing-368297"}],"nutrients":{"calories":1700.21,"protein":53.59,"fat":67.32,"carbohydrates":221.21}}""";

String workoutJson =
    """{"count":386,"next":"https://wger.de/api/v2/exercise/?limit=20&offset=20","previous":null,"results":[{"id":345,"uuid":"c788d643-150a-4ac7-97ef-84643c6419bf","name":"2HandedKettlebellSwing","exercise_base":9,"creation_date":"2015-08-03","category":10,"muscles":[],"muscles_secondary":[],"equipment":[10],"language":2,"license":2,"license_author":"deusinvictus","variations":[345,249],"author_history":["deusinvictus"]},{"id":1061,"uuid":"60d8018d-296f-4c62-a80b-f609a25d34ea","name":"AbdominalStabilization","exercise_base":56,"creation_date":"2022-10-11","category":10,"muscles":[6],"muscles_secondary":[14],"equipment":[4],"language":2,"license":2,"license_author":"wger.de","variations":[],"author_history":["wger.de"]},{"id":174,"uuid":"99881bdd-43d7-4c3b-82ed-9c187d0455b7","name":"Abduktoren-Maschine","exercise_base":12,"creation_date":"2013-07-19","category":9,"muscles":[8],"muscles_secondary":[],"equipment":[],"language":1,"license":1,"license_author":"flori","variations":[],"author_history":["flori"]},{"id":228,"uuid":"880bff63-6798-4ffc-a818-b2a1ccfec0f7","name":"ArnoldPress","exercise_base":20,"creation_date":"2014-03-09","category":13,"muscles":[],"muscles_secondary":[],"equipment":[3],"language":1,"license":3,"license_author":"bloody_disgrace","variations":[228,53,66,241,266],"author_history":["bloody_disgrace"]},{"id":227,"uuid":"53ca25b3-61d9-4f72-bfdb-492b83484ff5","name":"ArnoldShoulderPress","exercise_base":20,"creation_date":"2014-03-09","category":13,"muscles":[],"muscles_secondary":[],"equipment":[3],"language":2,"license":1,"license_author":"trzr23","variations":[227,329,256,190,152,155,123,119],"author_history":["trzr23"]},{"id":5,"uuid":"5675ae61-6597-4806-ae5c-2dda5a5ac03c","name":"AusfallschritteimGehen","exercise_base":206,"creation_date":"2013-05-05","category":9,"muscles":[10],"muscles_secondary":[8],"equipment":[3],"language":1,"license":2,"license_author":"wger.de","variations":[55,5],"author_history":["wger.de"]},{"id":55,"uuid":"27301836-ed7f-4510-83e7-66c0b8041a44","name":"AusfallschritteStehend","exercise_base":205,"creation_date":"2013-05-05","category":9,"muscles":[10],"muscles_secondary":[8],"equipment":[3],"language":1,"license":2,"license_author":"wger.de","variations":[55,5],"author_history":["wger.de"]},{"id":289,"uuid":"6add5973-86d0-4543-928a-6bb8b3f34efc","name":"AxeHold","exercise_base":31,"creation_date":"2014-11-02","category":8,"muscles":[],"muscles_secondary":[],"equipment":[3],"language":2,"license":1,"license_author":"GrosseHund","variations":[],"author_history":["GrosseHund"]},{"id":677,"uuid":"8e9d8968-323d-468c-9174-8cf11a105fad","name":"AxeHold","exercise_base":31,"creation_date":"2020-01-16","category":8,"muscles":[],"muscles_secondary":[],"equipment":[3],"language":1,"license":2,"license_author":"Wunschcoach","variations":[],"author_history":["Wunschcoach"]},{"id":1051,"uuid":"52a4cc0b-6d56-479d-b3b3-4a6a390cc379","name":"Ballcrunches","exercise_base":165,"creation_date":"2022-10-11","category":10,"muscles":[],"muscles_secondary":[],"equipment":[],"language":2,"license":2,"license_author":"","variations":[92,1051,94,1052,91,416,93,170,95,176],"author_history":[""]},{"id":38,"uuid":"4def60e7-ed8d-4a9d-bf76-ceb15ecf9779","name":"BankdrückenEng","exercise_base":76,"creation_date":"2013-05-05","category":8,"muscles":[5],"muscles_secondary":[2,4],"equipment":[1,8],"language":1,"license":2,"license_author":"wger.de","variations":[77,15,38,17,720,725,41,16,61],"author_history":["wger.de"]},{"id":77,"uuid":"06450bcb-03a8-4bd7-8349-ef677ee57ea3","name":"BankdrückenKH","exercise_base":75,"creation_date":"2013-05-05","category":11,"muscles":[4],"muscles_secondary":[2,5],"equipment":[8,3],"language":1,"license":2,"license_author":"wger.de","variations":[77,15,38,17,720,725,41,16,61],"author_history":["wger.de"]},{"id":15,"uuid":"198dcb2e-e35f-4b69-ae8b-e1124d438eae","name":"BankdrückenLH","exercise_base":73,"creation_date":"2013-05-05","category":11,"muscles":[4],"muscles_secondary":[2,5],"equipment":[1,8],"language":1,"license":2,"license_author":"wger.de","variations":[77,15,38,17,720,725,41,16,61],"author_history":["wger.de"]},{"id":343,"uuid":"1b9dc5bc-790b-4e21-a55d-f8b3115e94c5","name":"BarbellAbRollout","exercise_base":41,"creation_date":"2015-07-27","category":10,"muscles":[14],"muscles_secondary":[],"equipment":[1],"language":2,"license":2,"license_author":"sevae","variations":[],"author_history":["sevae"]},{"id":407,"uuid":"1215dad0-b7e0-42c6-80d4-112f69acb68a","name":"BarbellHackSquats","exercise_base":43,"creation_date":"2016-07-30","category":9,"muscles":[],"muscles_secondary":[],"equipment":[1],"language":2,"license":2,"license_author":"BePieToday","variations":[407,342,300,650,191,389,355,160,570,795,185,111,387],"author_history":["BePieToday"]},{"id":405,"uuid":"ae6a6c23-4616-49b7-a152-49d7461c2b7f","name":"BarbellLungesStanding","exercise_base":46,"creation_date":"2016-07-30","category":9,"muscles":[10],"muscles_secondary":[8],"equipment":[1],"language":2,"license":2,"license_author":"MikkoRuohola","variations":[1053,405,112,113],"author_history":["MikkoRuohola"]},{"id":1053,"uuid":"b368663d-f71f-4689-b462-76ac86a06362","name":"BarbellLungesWalking","exercise_base":802,"creation_date":"2022-10-11","category":9,"muscles":[],"muscles_secondary":[],"equipment":[1],"language":2,"license":2,"license_author":"wger.de","variations":[1053,405,112,113],"author_history":["wger.de"]},{"id":759,"uuid":"95b25f5e-4a01-48f1-a3df-2b7fe8fd624d","name":"BarbellReverseWristCurl","exercise_base":48,"creation_date":"2020-04-01","category":8,"muscles":[],"muscles_secondary":[],"equipment":[1,8],"language":2,"license":2,"license_author":"burenl","variations":[759,758],"author_history":["burenl"]},{"id":344,"uuid":"2cd5e256-20a7-4bc8-a7a8-d62bf8ce00cf","name":"BarbellTricepsExtension","exercise_base":50,"creation_date":"2015-07-27","category":8,"muscles":[5],"muscles_secondary":[2,4],"equipment":[1],"language":2,"license":2,"license_author":"sevae","variations":[344,1055,274,89,90],"author_history":["sevae"]},{"id":758,"uuid":"0fe97ed6-7d37-444c-90b6-f855cea68a6f","name":"BarbellWristCurl","exercise_base":51,"creation_date":"2020-04-01","category":8,"muscles":[],"muscles_secondary":[],"equipment":[1,8],"language":2,"license":2,"license_author":"burenl","variations":[759,758],"author_history":["burenl"]}]}""";
