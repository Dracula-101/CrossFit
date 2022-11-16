import 'dart:async';

import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/services/auth.dart';
import 'package:crossfit/utils/shared_preferences/shared_prefs.dart';
import 'package:crossfit/utils/toasts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:crossfit/styles/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../config/routes.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  //page view controller
  final PageController _pageController = PageController(initialPage: 0);
  double bmiStatus = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            UserInfoPage(
              pageController: _pageController,
              onFinished: ((p0) {
                setState(() {
                  bmiStatus = p0;
                });
              }),
            ),
            ProfilePage(
              pageController: _pageController,
              userBMI: bmiStatus,
            ),
            LoginPage(
              pageController: _pageController,
            )
          ],
        ),
      ),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  final PageController pageController;
  final Function(double)? onFinished;
  const UserInfoPage(
      {super.key, required this.pageController, required this.onFinished});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final int delay = 500;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  ValueNotifier loading = ValueNotifier(false);
  @override
  void initState() {
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        key: const Key('save'),
        onTap: () async {
          loading.value = true;
          // remove focus
          FocusScope.of(context).unfocus();
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            //save to shared prefs
            LocalUser user = LocalUser(
              name: _nameController.text.trim(),
              age: int.parse(_ageController.text.trim()),
              height: double.parse(_heightController.text.trim()),
              weight: double.parse(_weightController.text.trim()),
            );
            widget.onFinished
                ?.call((user.weight / (user.height * user.height)) * 10000);
            await sharedPrefs.setUserDetails(user);
            //move to next page
            widget.pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          }

          loading.value = false;
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ValueListenableBuilder(
            valueListenable: loading,
            builder: ((context, value, child) {
              return loading.value
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
            }),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AnimationConfiguration.staggeredList(
                position: 0,
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('About Me',
                              style: BoldText().boldVeryLargeText4),
                          Text(
                            'Tell us about yourself\nEnter your basic details for us to calculate your management plan',
                            style: LightText()
                                .lightNormalText
                                .copyWith(color: verylightGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredList(
                position: 1,
                delay: Duration(milliseconds: delay),
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            key: const Key('name'),
                            controller: _nameController,
                            decoration:
                                inputDecoration('Name', Icons.person, null),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onTap: () {
                              if (_scrollController.hasClients) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                          ),
                          spacer(20),
                          TextFormField(
                            key: const Key('age'),
                            controller: _ageController,
                            decoration:
                                inputDecoration('Age', Icons.person, null),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              }
                              if (int.parse(value) < 18) {
                                return 'You must be 18 years or older to use this app';
                              }
                              if (int.parse(value) > 100) {
                                return 'You must be 100 years or younger to use this app';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          spacer(20),
                          TextFormField(
                            key: const Key('height'),
                            controller: _heightController,
                            decoration: inputDecoration(
                                'Height (cms)', Icons.person, null),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your height';
                              }
                              if (int.parse(value) < 100) {
                                return 'You must be 100cm or taller to use this app';
                              }
                              if (int.parse(value) > 250) {
                                return 'You must be 250cm or shorter to use this app';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          spacer(20),
                          TextFormField(
                            key: const Key('weight'),
                            controller: _weightController,
                            decoration: inputDecoration(
                                'Weight (kg)', Icons.person, null),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your weight';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredList(
                position: 2,
                delay: Duration(milliseconds: delay),
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        '',
                        style: LightText()
                            .lightMediumText
                            .copyWith(color: dullWhite),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox spacer(double height) {
    return SizedBox(
      height: height,
    );
  }
}

class ProfilePage extends StatefulWidget {
  final PageController pageController;
  final double userBMI;
  const ProfilePage(
      {super.key, required this.pageController, required this.userBMI});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  int delay = 500;
  User? user;
  List<String>? userBMIstatus;
  bool isMale = false, isFemale = false;
  TextEditingController? _locationController;
  DateTime? birthDate;
  ValueNotifier loading = ValueNotifier(false);
  @override
  void initState() {
    userBMIstatus = getBMIstatus();
    _locationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _locationController!.dispose();
    super.dispose();
  }

  List<String> getBMIstatus() {
    double bmi = widget.userBMI;
    if (bmi < 18.5) {
      return [
        'A bit underweight!',
        'Try to ',
      ];
    }
    if (bmi >= 18.5 && bmi <= 24.9) {
      return [
        'You are perfectly healthy!',
        'Keep it up!',
      ];
    }
    if (bmi >= 25 && bmi <= 29.9) {
      return [
        'A bit overweight!',
        'You can easily lose weight by registering your daily activities and following a healthy diet'
      ];
    }
    if (bmi >= 30) {
      return [
        'Your BMI is in the obese range!!',
        'Try to exercise more and eat less junk food!'
      ];
    }
    return [
      'Unknown BMI',
      'Please check your details and try again',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () async {
          if (!isMale && !isFemale) {
            SnackBars.showSnackBar('Not gender selected',
                'Please select a gender in order to continue', context,
                position: SnackPosition.TOP);
            return;
          }
          loading.value = true;
          FocusScope.of(context).unfocus();
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            await sharedPrefs.setOtherDetails(
                isMale ? 'Male' : 'Female', _locationController!.text.trim());
            widget.pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          }

          loading.value = false;
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ValueListenableBuilder(
            valueListenable: loading,
            builder: ((context, value, child) {
              return loading.value
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
            }),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            children: [
              AnimationConfiguration.staggeredList(
                position: 0,
                delay: Duration(milliseconds: delay),
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userBMIstatus?.first ?? '',
                            style: BoldText().boldVeryLargeText3),
                        Text(
                          'Your BMI is ${widget.userBMI.toStringAsFixed(2)}',
                          style: BoldText().boldMediumText,
                        ),
                        Text(
                          userBMIstatus?.last ?? '',
                          style: LightText()
                              .lightMediumText
                              .copyWith(color: dullWhite),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredList(
                position: 1,
                delay: Duration(milliseconds: delay),
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: LightText().lightMediumText,
                          ),
                          Wrap(
                            children: [
                              ChoiceChip(
                                  label: Row(children: const [
                                    // male
                                    Icon(
                                      FontAwesomeIcons.person,
                                    ),
                                    Text(' Male')
                                  ]),
                                  selected: isMale,
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == true) {
                                        isMale = true;
                                        isFemale = false;
                                      } else {
                                        isMale = false;
                                      }
                                    });
                                  }),
                              ChoiceChip(
                                  label: Row(children: const [
                                    // male
                                    Icon(
                                      FontAwesomeIcons.personDress,
                                    ),
                                    Text(' Female')
                                  ]),
                                  selected: isFemale,
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == true) {
                                        isFemale = true;
                                        isMale = false;
                                      } else {
                                        isFemale = false;
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredList(
                position: 2,
                delay: Duration(milliseconds: delay),
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: _locationController,
                        decoration: inputDecoration(
                            'Location', Icons.location_on_rounded, null),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Location';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredList(
                position: 3,
                delay: Duration(milliseconds: delay),
                duration: Duration(milliseconds: delay),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: dullWhite,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              'CrossFit uses precise measurements to calculate your details. Please enter your details carefully',
                              style: LightText()
                                  .lightSmallText
                                  .copyWith(color: dullWhite),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final PageController pageController;
  const LoginPage({super.key, required this.pageController});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  int delay = 500;
  LocalUser? user;
  ValueNotifier loading = ValueNotifier(false);
  User? signedInUser;
  bool isSignedIn = false;
  Timer? timer;
  getUserDetails() async {
    LocalUser user = await sharedPrefs.getUserDetails();
    setState(() {
      this.user = user;
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () async {
          loading.value = true;
          FocusScope.of(context).unfocus();
          if (signedInUser?.email != null) {
            // user is already signed in

          } else {
            signedInUser =
                await Authentication.signInWithGoogle(context: context);
            if (user != null) {
              timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homePage, (route) => false);
              });
              setState(() {
                isSignedIn = true;
              });
            }
          }
          loading.value = false;
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          decoration: !isSignedIn
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                )
              : null,
          child: ValueListenableBuilder(
            valueListenable: loading,
            builder: ((context, value, child) {
              return loading.value
                  ? const CircularProgressIndicator()
                  : !isSignedIn
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              FontAwesomeIcons.google,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Redirecting  ',
                              style: BoldText().boldVeryLargeText,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            )
                          ],
                        );
            }),
          ),
        ),
      ),
      body: SafeArea(
        child: !isSignedIn
            ? ListView(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                children: [
                  slideAnimation(
                    position: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Almost There!',
                          style: BoldText().boldVeryLargeText5,
                        ),
                        Text(
                          'Sign up your email through google in order to continue',
                          style: LightText().lightSmallText,
                        ),
                      ],
                    ),
                  ),
                  slideAnimation(
                    position: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your details',
                            style: LightText().lightVeryLargeText1,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Name: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: user?.name,
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Age: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: user?.age.toString(),
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Gender: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: user?.gender,
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                     
                  slideAnimation(
                    position: 2,
                    child: RichText(
                      text: TextSpan(
                        text: 'By signing up, you agree to our ',
                        style: LightText().lightSmallText,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms of Service',
                            style: LightText().lightSmallText.copyWith(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: LightText().lightSmallText,
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: LightText().lightSmallText.copyWith(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : ListView(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                children: [
                  slideAnimation(
                    position: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${signedInUser?.displayName}',
                          style: BoldText().boldVeryLargeText5,
                        ),
                        Text(
                          'You are now signed in with your google account',
                          style: LightText().lightSmallText,
                        ),
                      ],
                    ),
                  ),
                  slideAnimation(
                    position: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Your details',
                            style: LightText().lightVeryLargeText1,
                          ),
                          signedInUser?.photoURL != null
                              ? SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: ClipOval(
                                    child: Material(
                                      color: lightGrey,
                                      child: Image.network(
                                        signedInUser!.photoURL!,
                                        fit: BoxFit.fitHeight,
                                        cacheHeight: 150,
                                        cacheWidth: 150,
                                      ),
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: Material(
                                    color: lightGrey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                        color: lightGreyContrast,
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Name: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: user?.name,
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Email: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: signedInUser?.email,
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Age: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: user?.age.toString(),
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Gender: ',
                                  style: BoldText().boldLargeText.copyWith(
                                        color: dullWhite,
                                      ),
                                ),
                                TextSpan(
                                  text: user?.gender,
                                  style: LightText().lightMediumText.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),   
                ],
              ),
      ),
    );
  }
}
