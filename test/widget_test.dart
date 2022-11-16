import 'package:crossfit/config/routes.dart';
import 'package:crossfit/main.dart';
import 'package:crossfit/screens/splash_screens/intro_page.dart';
import 'package:crossfit/screens/splash_screens/profile_setup.dart/profile_setup.dart';
import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Widget Testing', () {
    setUp(() async {
      // shared prefs
      WidgetsFlutterBinding.ensureInitialized();
      sharedPrefs = SharedPrefs(await SharedPreferences.getInstance());
      firstEntry = await sharedPrefs.getBool('firstEntry');
    });

    // testWidgets('Card Test', (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       body: modernCard(
    //         const Text('Card'),
    //       ),
    //     ),
    //   ));

    //   expect(find.text('Card'), findsOneWidget);
    // });

    // test('Shared Preferences', () async {
    //   SharedPreferences.setMockInitialValues({});
    //   final prefs = await SharedPreferences.getInstance();
    //   prefs.setString('name', 'John');
    //   expect(prefs.getString('name'), 'John');
    // });

    testWidgets('Profile Page', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ProfileSetup(),
      ));
      await sharedPrefs.clear();
      // enter name, height weight and age in text fields
      //get the text field that says name
      final nameField = find.byKey(const Key('name'));
      await tester.enterText(nameField, 'John');
      final heightField = find.byKey(const Key('height'));
      await tester.enterText(heightField, '170');
      final weightField = find.byKey(const Key('weight'));
      await tester.enterText(weightField, '60');
      final ageField = find.byKey(const Key('age'));
      await tester.enterText(ageField, '20');

      await tester.tap(find.byKey(const Key('save')));
      await tester.pump();

      // verify that shared prefs has been updated
      LocalUser user = await sharedPrefs.getUserDetails();
      // check if the name is John and the height is 170
      expect(user.name, 'John');
      expect(user.height, 170);
      expect(user.weight, 60);
      expect(user.age, 20);
    });

    testWidgets('Profile Page', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ProfileSetup(),
      ));
      await sharedPrefs.clear();
      // enter name, height weight and age in text fields
      //get the text field that says name
      final nameField = find.byKey(const Key('name'));
      await tester.enterText(nameField, 'John');
      final heightField = find.byKey(const Key('height'));
      await tester.enterText(heightField, '170');
      final weightField = find.byKey(const Key('weight'));
      await tester.enterText(weightField, '60');
      final ageField = find.byKey(const Key('age'));
      await tester.enterText(ageField, '20');

      await tester.tap(find.byKey(const Key('save')));
      await tester.pump();

      // verify that shared prefs has been updated
      LocalUser user = await sharedPrefs.getUserDetails();
      // check if the name is John and the height is 170
      expect(user.name, 'John');
      expect(user.height, 170);
      expect(user.weight, 60);
      expect(user.age, 20);
    });

    testWidgets('Intro Page', (WidgetTester tester) async {
      await tester.pumpWidget(GetMaterialApp(
        routes: testRoutes,
        initialRoute: '/',
      ));
      await sharedPrefs.clear();
      //tap on the next button
      await tester.tap(find.byKey(const Key('next')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('next')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('next')));
      await tester.pump();
      //wait for one sec
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('done')));
      await tester.pump();

      // verify that shared prefs has been updated
      bool firstEntry = await sharedPrefs.getBool('firstEntry');
      expect(firstEntry, true);
    });
  });
}
