import 'package:crossfit/strava/domain/model/model_detailed_activity.dart';
import 'package:crossfit/strava/strava_client.dart';
import 'package:crossfit/utils/custom_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../../styles/styles.dart';

class StravaDetailPage extends StatefulWidget {
  final String id;
  final String name;
  const StravaDetailPage({super.key, required this.id, required this.name});

  @override
  State<StravaDetailPage> createState() => _StravaDetailPageState();
}

class _StravaDetailPageState extends State<StravaDetailPage>
    with SingleTickerProviderStateMixin {
  late Future<DetailedActivity>? _futureActivity;
  late List<MapLatLng> _polylinePoints;
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _futureActivity =
        stravaClient?.activities.getActivity(int.parse(widget.id));
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward(from: 0);
  }

  addLatLng(startLngLat, endLatLng, String polylines) {
    final userPolyline = decodePolyline(polylines, accuracyExponent: 5);
    _polylinePoints = [
      MapLatLng(startLngLat[0], startLngLat[1]),
    ];
    for (var i = 0; i < userPolyline.length; i++) {
      _polylinePoints.add(MapLatLng(double.parse(userPolyline[i][0].toString()),
          double.parse(userPolyline[i][1].toString())));
    }
    _polylinePoints.add(MapLatLng(endLatLng[0], endLatLng[1]));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.name),
            floating: false,
            pinned: true,
            primary: true,
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
                FutureBuilder(
                  future: _futureActivity,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.map!.summaryPolyline != null &&
                          snapshot.data!.map!.summaryPolyline!.isNotEmpty &&
                          snapshot.data!.startLatlng != null &&
                          snapshot.data!.endLatlng != null) {
                        addLatLng(
                            snapshot.data?.startLatlng,
                            snapshot.data?.endLatlng,
                            snapshot.data?.map?.polyline ?? '');
                        return stravaMap(snapshot);
                      } else {
                        return Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            child:
                                const Center(child: Text('No map available')));
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: white,
                          strokeWidth: 1,
                        ),
                      );
                    }
                  },
                ),
                context),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder(
                  future: _futureActivity,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return stravaInfo(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _futureActivity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (snapshot.data?.description != null)
                          Text(
                            snapshot.data?.description ?? '',
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                            ),
                          ),
                        Text(
                          'Segments',
                          style: BoldText().boldVeryLargeText,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Text("${snapshot.error}"),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          ),
          FutureBuilder(
            future: _futureActivity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return segmentsInfo(snapshot.data);
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Text("${snapshot.error}"),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          ),
          FutureBuilder(
            future: _futureActivity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                    child: Text(
                      'Laps',
                      style: BoldText().boldVeryLargeText,
                    ),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          ),
          FutureBuilder(
            future: _futureActivity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return lapInfo(snapshot.data);
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Text("${snapshot.error}"),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          ),
          FutureBuilder(
            future: _futureActivity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //highlighted kudosers
                return SliverToBoxAdapter(
                  child: modernCard(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (snapshot.data?.calories != null)
                        customText(snapshot.data?.calories.toString() ?? '',
                            null, 'Calories'),
                      //workout type
                      if (snapshot.data?.workoutType != null)
                        customText(snapshot.data?.workoutType.toString() ?? '',
                            null, 'Workout Type'),
                      //private
                      if (snapshot.data?.private != null)
                        customText(
                            snapshot.data?.private ?? false ? 'Yes' : 'No',
                            null,
                            'Private'),
                    ],
                  )),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Container stravaInfo(DetailedActivity? activity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${formattedTime(DateTime.parse(activity?.startDateLocal ?? ''))} on ${formattedDate(DateTime.parse(activity?.startDateLocal ?? ''))}",
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customText(
                  ((activity?.distance ?? 0.0) / 1000).toStringAsFixed(2),
                  'km',
                  "Distance"),
              customText(
                  Duration(seconds: activity?.movingTime ?? 0)
                      .toString()
                      .split('.')
                      .first,
                  null,
                  "Moving Time"),
              customText(
                  (activity?.totalElevationGain ?? 0.0).toStringAsFixed(2),
                  'm',
                  "Elevation"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Speed',
                style: BoldText().boldMediumText,
              ),
              Row(
                children: [
                  chipButton(
                    text: 'Max ${activity?.maxSpeed?.toStringAsFixed(2)}km/h',
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    textStyle: NormalText().smallText,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  chipButton(
                    text:
                        'Avg ${activity?.averageSpeed?.toStringAsFixed(2)}km/h',
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    textStyle: NormalText().smallText,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Elapsed Time', style: BoldText().boldMediumText),
              const SizedBox(
                width: 10,
              ),
              Text(
                Duration(seconds: activity?.elapsedTime ?? 0)
                    .toString()
                    .split('.')
                    .first,
              )
            ],
          ),
        ],
      ),
    );
  }

  segmentsInfo(DetailedActivity? snapshot) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              title: Text('${snapshot?.segmentEfforts?[index].name}'),
              subtitle:
                  Text('${snapshot?.segmentEfforts?[index].distance} meters'),
              trailing: Column(
                children: [
                  //time
                  Text(
                    '${snapshot?.segmentEfforts?[index].movingTime} seconds',
                    style: NormalText().smallText,
                  ),
                  //speed
                  Text(
                    '${(((snapshot?.segmentEfforts?[index].distance ?? 0) / (snapshot?.segmentEfforts?[index].elapsedTime ?? 0.0))).toStringAsFixed(2)} km/h',
                    style: NormalText().smallText,
                  ),
                ],
              ));
        },
        childCount: snapshot?.segmentEfforts?.length ?? 0,
      ),
    );
  }

  lapInfo(DetailedActivity? activity) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              title: Text('${activity?.laps?[index].name}'),
              subtitle: Text('${activity?.laps?[index].distance} meters'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //time
                  Text(
                    '${activity?.laps?[index].movingTime} seconds',
                    style: NormalText().smallText,
                  ),
                  //speed
                  Text(
                    '${(((activity?.laps?[index].distance ?? 0) / (activity?.laps?[index].elapsedTime ?? 0.0))).toStringAsFixed(2)} km/h',
                    style: NormalText().smallText,
                  ),
                ],
              ));
        },
        childCount: activity?.laps?.length ?? 0,
      ),
    );
  }

  formattedTime(DateTime date) {
    //time formate 12 hr
    return "${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute} ${date.hour > 12 ? 'PM' : 'AM'}";
  }

  formattedDate(DateTime date) {
    //formate day, month, date, year
    return "${getWeekDay(date.weekday)}, ${getMonth(date.month)} ${date.day}, ${date.year}";
  }

  getWeekDay(int day) {
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Monday";
    }
  }

  getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "January";
    }
  }

  Container stravaMap(AsyncSnapshot<DetailedActivity> snapshot) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: SfMaps(
        layers: [
          MapTileLayer(
            key: UniqueKey(),
            controller: MapTileLayerController(),
            initialLatLngBounds: MapLatLngBounds(
              MapLatLng(snapshot.data?.startLatlng?[0] ?? 0,
                  snapshot.data?.startLatlng?[1] ?? 0),
              MapLatLng(snapshot.data?.endLatlng?[0] ?? 0,
                  snapshot.data?.endLatlng?[1] ?? 0),
            ),
            zoomPanBehavior: MapZoomPanBehavior(
              zoomLevel: 12,
              focalLatLng: MapLatLng(snapshot.data?.startLatlng?[0] ?? 0,
                  snapshot.data?.startLatlng?[1] ?? 0),
            ),
            onWillPan: (details) {
              return true;
            },
            onWillZoom: (details) {
              return true;
            },
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // take mean of start and end latlng tfor initial focus
            initialFocalLatLng: MapLatLng(
                ((snapshot.data?.startLatlng?[0] ?? 0.0) +
                        (snapshot.data?.endLatlng?[0] ?? 0.0)) /
                    2,
                ((snapshot.data?.startLatlng?[1] ?? 0.0) +
                        (snapshot.data?.endLatlng?[1] ?? 0.0)) /
                    2),
            initialMarkersCount: _polylinePoints.length,
            initialZoomLevel: 14,
            markerBuilder: (BuildContext context, int index) {
              if (index == _polylinePoints.length - 1) {
                return MapMarker(
                  latitude: _polylinePoints[index].latitude,
                  longitude: _polylinePoints[index].longitude,
                  child: Transform.translate(
                    offset: const Offset(0.0, -8.0),
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 20),
                  ),
                );
              } else {
                return MapMarker(
                  latitude: _polylinePoints[index].latitude,
                  longitude: _polylinePoints[index].longitude,
                  iconType: MapIconType.circle,
                  iconColor: Colors.white,
                  iconStrokeWidth: 1.0,
                  size: const Size(2.0, 2.0),
                  iconStrokeColor: Colors.black,
                );
              }
            },
            sublayers: [
              MapPolylineLayer(
                polylines: {
                  MapPolyline(
                    points: _polylinePoints,
                    width: 6.0,
                  )
                },
                animation: _animation,
              ),
            ],
          ),
        ],
      ),
    );
  }

  customText(String upperText, String? measure, String downText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: upperText,
            style: LightText().lightVeryLargeText1,
            children: <TextSpan>[
              if (measure != null)
                (TextSpan(text: measure, style: LightText().lightMediumText))
            ],
          ),
        ),
        Text(
          downText,
          style: LightText().lightSmallText,
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.child, this.context);
  final Widget child;
  final BuildContext context;

  @override
  double get minExtent => MediaQuery.of(context).size.height * 0.15;
  @override
  double get maxExtent => MediaQuery.of(context).size.height * 0.4;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: clampDouble(
          MediaQuery.of(context).size.height * 0.4 - shrinkOffset,
          minExtent,
          maxExtent),
      color: darkGrey,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
