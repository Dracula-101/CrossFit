import 'dart:async';

import 'package:crossfit/animations/custom_animations.dart';
import 'package:crossfit/config/routes.dart';
import 'package:crossfit/screens/home_pages/third-party/strava_details.dart';
import 'package:crossfit/strava/domain/model/model_authentication_response.dart';
import 'package:crossfit/strava/domain/model/model_authentication_scopes.dart';
import 'package:crossfit/strava/domain/model/model_detailed_activity.dart';
import 'package:crossfit/strava/domain/model/model_detailed_athlete.dart';
import 'package:crossfit/strava/domain/model/model_fault.dart';
import 'package:crossfit/strava/domain/model/model_summary_activity.dart';
import 'package:crossfit/strava/domain/model/model_summary_segment.dart';
import 'package:crossfit/strava/strava_client.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../../styles/styles.dart';

class StravaPage extends StatefulWidget {
  const StravaPage({super.key});

  @override
  State<StravaPage> createState() => _StravaPageState();
}

class _StravaPageState extends State<StravaPage> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController tabController;
  bool isLoggedIn = false;
  TokenResponse? token;
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getStravaDetails();
    super.initState();
  }

  getStravaDetails() async {
    stravaClient ??= StravaClient(
      secret: "dc0725bae2d83fa42f3bdb11bc9acc7f9470a9f4",
      clientId: "93450",
    );
    var token = await stravaClient!.getStravaAuthToken();
    if (token != null) {
      setState(() {
        this.token = token;
        isLoggedIn = true;
      });
    }
  }

  FutureOr<Null> showErrorMessage(dynamic error, dynamic stackTrace) {
    if (error is Fault) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Did Receive Fault"),
              content: Text(
                  "Message: ${error.message}\n-----------------\nErrors:\n${(error.errors ?? []).map((e) => "Code: ${e.code}\nResource: ${e.resource}\nField: ${e.field}\n").toList().join("\n----------\n")}"),
            );
          });
    }
  }

  void testAuthentication() {
    stravaClient!.authentication.authenticate(
      scopes: [
        AuthenticationScope.read_all,
        AuthenticationScope.profile_read_all,
        AuthenticationScope.activity_read_all,
      ],
      forceShowingApproval: true,
      redirectUrl: 'crossfit://strava',
    ).then((value) {
      setState(() {
        token = value;
        isLoggedIn = true;
      });
    }).onError(showErrorMessage);
  }

  void testDeauth() {
    stravaClient!.authentication.deAuthorize().then((value) {
      setState(() {
        isLoggedIn = false;
        token = null;
        _textEditingController.clear();
      });
    }).catchError(showErrorMessage);
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
                        !isLoggedIn
                            ? IconButton(
                                onPressed: () {
                                  testAuthentication();
                                },
                                icon: const Icon(
                                  Icons.login,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  testDeauth();
                                },
                                icon: const Icon(
                                  Icons.logout,
                                ),
                              )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        title: const Text(
                          "Strava",
                        ),
                        expandedTitleScale: 2.5,
                        background: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.1),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              FontAwesomeIcons.strava,
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
                if (isLoggedIn)
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        onTap: (index) {
                          _selectedIndex.value = index;
                        },
                        controller: tabController,
                        tabs: const [
                          Tab(text: "Activities"),
                          Tab(text: "Segments"),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
              ];
            },
            body: Builder(
              builder: (context) {
                return ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context, value, child) {
                    return isLoggedIn
                        ? IndexedStack(
                            index: value,
                            children: [
                              CustomScrollView(slivers: [
                                // _login(),
                                _apiGroups(),
                                const StarvaActivities(),
                              ]),
                              const CustomScrollView(
                                  slivers: [StravaSegments()]),
                            ],
                          )
                        : const NoStravaLogin();
                  },
                );
              },
            ),
          )),
    );
  }

  Widget _apiGroups() {
    return SliverToBoxAdapter(
      child: FutureBuilder<DetailedAthlete>(
        future: stravaClient?.athletes.getAuthenticatedAthlete(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                      .data?.profile ??
                                  'https://images.unsplash.com/photo-1610000000000-000000000000?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
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
                                    '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
                                    style: NormalText().largeText,
                                  ),
                                  chipButton(
                                      text: snapshot.data?.sex == "M"
                                          ? "Male"
                                          : "Female"),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Followers ${snapshot.data?.followerCount}\t | Friends ${snapshot.data?.friendCount}',
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
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget spacedRow(Widget left, Widget right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        left,
        right,
      ],
    );
  }

  Widget spacedText(String left, String right) {
    return spacedRow(
      Text(
        left,
        style: BoldText().boldLargeText,
      ),
      Text(
        right,
        style: NormalText().mediumText,
      ),
    );
  }
}

class StarvaActivities extends StatefulWidget {
  const StarvaActivities({super.key});

  @override
  State<StarvaActivities> createState() => StarvaActivitiesState();
}

class StarvaActivitiesState extends State<StarvaActivities> {
  Future<List<SummaryActivity>>? _future;

  @override
  void initState() {
    _future = stravaClient?.activities.listLoggedInAthleteActivities(
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 10000)),
      1,
      30,
    );
    super.initState();
  }

  getActivites() async {
    final response =
        await stravaClient?.activities.listLoggedInAthleteActivities(
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 10000)),
      1,
      30,
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Please Login to Strava"),
                ),
              );
            }
            if (snapshot.data?.isNotEmpty ?? false) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return StravaActivityCard(
                      activity: snapshot.data![index],
                    );
                  },
                  childCount: snapshot.data?.length ?? 0,
                ),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("No Activities Found"),
                ),
              );
            }
          } else {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                ),
              ),
            );
          }
        });
  }
}

class StravaSegments extends StatefulWidget {
  const StravaSegments({super.key});

  @override
  State<StravaSegments> createState() => _StravaSegmentsState();
}

class _StravaSegmentsState extends State<StravaSegments> {
  Future<List<SummarySegment>?>? segments;

  @override
  void initState() {
    segments = stravaClient?.segments.listStarredSegments(1, 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: segments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.isEmpty ?? false) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "No Segments Found",
                    style: BoldText().boldExtraLargeText,
                  ),
                ),
              ),
            );
          }
          return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return StravaSegmentCard(segment: snapshot.data![index]);
          }, childCount: snapshot.data?.length ?? 0));
        } else if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text('Error Loading Segments'),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class StravaSegmentCard extends StatelessWidget {
  final SummarySegment segment;
  const StravaSegmentCard({super.key, required this.segment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        segment.name ?? '',
        style: NormalText().mediumText,
      ),
      subtitle: Text(
        '${segment.city} ${segment.state} ${segment.country}',
        style: NormalText().mediumText,
      ),
      trailing: Text(
        '${segment.distance}m',
        style: NormalText().smallText,
      ),
    );
  }
}

class StravaActivityCard extends StatelessWidget {
  final SummaryActivity activity;
  const StravaActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.to(
        () => StravaDetailPage(
            id: activity.id.toString(), name: activity.name ?? ''),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      leading: ((activity.startLatlng?.isNotEmpty ?? false) &&
              (activity.startLatlng?.isNotEmpty ?? false))
          ? MapWidget(
              polyLineMap: activity.map,
              startLngLat: activity.startLatlng!,
              endLatLng: activity.endLatlng!,
            )
          : Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: darkGreyContrast,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.directions_bike,
                color: Colors.white,
              ),
            ),
      title: Text(
        activity.name ?? '',
        style: NormalText().normalText,
      ),
      subtitle: Text(
        activity.startDateLocal?.split('T').first.toString() ?? '',
        style: NormalText().smallestText,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${activity.distance}m',
            style: NormalText().smallText,
          ),
          Text(
            Duration(seconds: activity.movingTime ?? 0)
                .toString()
                .split('.')
                .first,
            style: NormalText().smallerText,
          ),
        ],
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  final PolyLineMap? polyLineMap;
  final List<double> startLngLat;
  final List<double> endLatLng;
  const MapWidget(
      {super.key,
      this.polyLineMap,
      required this.startLngLat,
      required this.endLatLng});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late List<MapLatLng> _polylinePoints;

  @override
  void initState() {
    super.initState();
    addLatLng();
  }

  addLatLng() {
    _polylinePoints = [
      MapLatLng(widget.startLngLat[0], widget.startLngLat[1]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.15,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightGreyContrast,
      ),
      clipBehavior: Clip.antiAlias,
      child: SfMaps(
        layers: [
          MapTileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            initialFocalLatLng:
                MapLatLng((widget.startLngLat[0]), (widget.startLngLat[1])),
            initialMarkersCount: _polylinePoints.length,
            initialZoomLevel: 15,
            markerBuilder: (BuildContext context, int index) {
              if (index == _polylinePoints.length - 1) {
                return MapMarker(
                  latitude: _polylinePoints[index].latitude,
                  longitude: _polylinePoints[index].longitude,
                  child: Transform.translate(
                    offset: Offset(0.0, -8.0),
                    child: Icon(Icons.location_on, color: Colors.red, size: 20),
                  ),
                );
              }
              return MapMarker(
                latitude: _polylinePoints[index].latitude,
                longitude: _polylinePoints[index].longitude,
              );
            },
            sublayers: [
              MapPolylineLayer(
                polylines: {
                  MapPolyline(
                    points: _polylinePoints,
                    width: 6.0,
                  )
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoStravaLogin extends StatelessWidget {
  const NoStravaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: lightGreyContrast,
            ),
            child: Image.asset('assets/images/dark-strava-fitbit.png'),
          ),
          const SizedBox(height: 40),
          Text(
            'Please Login to Strava',
            style: NormalText().veryLargeText,
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: darkGrey,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
