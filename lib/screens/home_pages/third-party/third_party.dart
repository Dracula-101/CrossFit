import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StravaFitbit extends StatefulWidget {
  const StravaFitbit({super.key});

  @override
  State<StravaFitbit> createState() => _StravaFitbitState();
}

class _StravaFitbitState extends State<StravaFitbit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Connect ', style: BoldText().boldVeryLargeText),
                    Text('with different accounts',
                        style: LightText().lightNormalText),
                  ],
                ),
              ),
              pinned: true,
              elevation: 4,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                height: MediaQuery.of(context).size.height * 0.2,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(252, 82, 0, 0.02),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    width: 4,
                    color: const Color.fromRGBO(252, 82, 0, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromRGBO(252, 82, 0, 1).withOpacity(0.5),
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      FontAwesomeIcons.strava,
                      size: 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      'Strava',
                      style: BoldText().boldVeryLargeText3,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 167, 176, 0.02),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color.fromRGBO(27, 167, 176, 1),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(27, 167, 176, 1)
                          .withOpacity(0.5),
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.fitbit_rounded,
                      size: 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      'Fitbit',
                      style: BoldText().boldVeryLargeText3,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10, top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.info,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                              'You can check on your info on respective accounts'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.info,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                              'Just Log in and give the required permissions'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.info,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                              'Check your stats on the dashboard and compare them with your friends'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
