import 'package:crossfit/fitbit/fibit_client.dart';
import 'package:crossfit/fitbit/local_manager.dart';
import 'package:crossfit/fitbit/utils/formats.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../animations/custom_animations.dart';
import '../../../fitbit/fitbitter.dart';
import '../../../styles/styles.dart';

class FitbitPage extends StatefulWidget {
  const FitbitPage({super.key});

  @override
  State<FitbitPage> createState() => _FitbitPageState();
}

class _FitbitPageState extends State<FitbitPage> {
  bool isLoggedIn = false;
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  Future<FitbitAccountData>? _futureAccountData;
  Future<FitbitActivityData>? _futureActivityData;

  @override
  void initState() {
    checkFitbitData();
    callFutures();
    super.initState();
  }

  checkFitbitData() async {
    final result = await LocalStorageManager.getDetails();
    if (result[0] != "" && result[1] != "" && result[2] != "") {
      fitbit = FitbitCredentials(
        userID: result[0],
        fitbitAccessToken: result[1],
        fitbitRefreshToken: result[2],
      );
      setState(() {
        isLoggedIn = true;
      });
    }
    FitbitClient.initializeFitbit();
  }

  initalizeFibit() async {
    fitbit = await FitbitClient.authorize();
    setState(() {
      isLoggedIn = true;
    });
  }

  callFutures() {
    _futureAccountData = FitbitClient.getAccountDetails();
    _futureActivityData = FitbitClient.getActivityDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      actions: [
                        !(isLoggedIn)
                            ? IconButton(
                                onPressed: () {
                                  initalizeFibit();
                                },
                                icon: const Icon(
                                  Icons.login,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  FitbitClient.deauthorize();
                                  setState(() {
                                    isLoggedIn = false;
                                  });
                                },
                                icon: const Icon(
                                  Icons.logout,
                                ),
                              )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        title: const Text(
                          "Fitbit",
                        ),
                        expandedTitleScale: 2.5,
                        background: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.1),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.fitbit,
                              size: 70,
                              color: lightGrey,
                            ),
                          ),
                        ),
                      ),
                      expandedHeight: MediaQuery.of(context).size.height * 0.15,
                      floating: false,
                      pinned: true,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ),
                ),
              ];
            },
            body: Builder(
              builder: (context) {
                return ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context, value, child) {
                    return isLoggedIn
                        ? IndexedStack(index: value, children: [
                            CustomScrollView(slivers: [
                              // _login(),
                              _profileInfo(),
                              _activityTitle(),
                              _activityInfo(),
                            ]),
                            const CustomScrollView(
                                // slivers: [StravaSegments()],
                                ),
                          ])
                        : const NoLoginPage(
                            title: "Please login to Fitbit",
                          );
                  },
                );
              },
            ),
          )),
    );
  }

  Widget _profileInfo() {
    return SliverToBoxAdapter(
      //TODOD change dynamic
      child: FutureBuilder<FitbitAccountData>(
        future: _futureAccountData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalAnimation(
                  position: 0,
                  child: modernCard(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.13,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.126,
                              backgroundImage: NetworkImage(snapshot
                                      .data?.avatar ??
                                  'https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png'),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.data?.displayName ?? "",
                                    style: NormalText().largeText,
                                  ),
                                  chipButton(text: snapshot.data?.gender ?? ""),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                formattedDOB(snapshot.data!.dateOfBirth!),
                                style: NormalText().smallText,
                              ),
                              Text(
                                'Height: ${snapshot.data?.height} cm',
                                style: NormalText().smallText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _activityTitle() {
    return SliverToBoxAdapter(
        child: FutureBuilder(
      future: _futureActivityData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 5, left: 2),
            child: Text(
              "Activities",
              style: BoldText().boldVeryLargeText1,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    ));
  }

  Widget _activityInfo() {
    return FutureBuilder<FitbitActivityData>(
      future: _futureActivityData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.activities?.isEmpty ?? false) {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("No activities found"),
              ),
            );
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (
                  context,
                  index,
                ) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          title: Text(
                              snapshot.data?.activities?[index].activityName ??
                                  'Run ${index + 1}'),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  '${snapshot.data?.activities?[index].distance?.toStringAsFixed(2)} km in ${formattedSeconds(snapshot.data?.activities?[index].duration)}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.fire,
                                    size: 20,
                                    color: dullGreyContrast,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '${snapshot.data?.activities?[index].calories} cal'),
                                ],
                              )
                            ],
                          ),
                          subtitle: Text(
                              '${snapshot.data?.activities?[index].startTime.toString().substring(0, 10)}'),
                        ),
                        activityLevel(
                            snapshot.data?.activities?[index].activityLevel,
                            Duration(
                                    milliseconds: snapshot
                                            .data?.activities?[index].duration
                                            ?.toInt() ??
                                        0)
                                .inMinutes),
                      ],
                    ),
                  );
                },
                childCount: snapshot.data?.activities?.length ?? 0,
              ),
            );
          }
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }

  formattedDOB(DateTime time) {
    return "${time.day}/${time.month}/${time.year}";
  }

  formattedSeconds(double? milliseconds) {
    return Duration(milliseconds: (milliseconds?.toInt() ?? 0))
        .toString()
        .split('.')
        .first
        .padLeft(8, "0");
  }

  Widget activityLevel(List<ActivityLevel>? activityLevel, int? totalDuration) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activity levels', style: BoldText().boldNormalText),
        const SizedBox(
          height: 2,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (activityLevel![0].minutes != 0)
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.8 *
                      ((activityLevel[0].minutes ?? 0.0) / totalDuration!),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text(
                    '${activityLevel[0].name} (${activityLevel[0].minutes} min)',
                    style: NormalText().smallText,
                  ),
                ),
              if (activityLevel[1].minutes != 0)
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.8 *
                      ((activityLevel[1].minutes ?? 0.0) / totalDuration!),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${activityLevel[1].name} (${activityLevel[1].minutes} min) ',
                    style: NormalText().smallText,
                  ),
                ),
              if (activityLevel[2].minutes != 0)
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.8 *
                      ((activityLevel[2].minutes ?? 0.0) / totalDuration!),
                  decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${activityLevel[2].name} (${activityLevel[2].minutes} min)',
                    style: NormalText().smallText,
                  ),
                ),
              if (activityLevel[3].minutes != 0)
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.8 *
                      ((activityLevel[3].minutes ?? 0.0) / totalDuration!),
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${activityLevel[3].name} (${activityLevel[3].minutes} min)',
                    style: NormalText().smallText,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
