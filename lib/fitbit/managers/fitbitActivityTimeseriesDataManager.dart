import 'package:logger/logger.dart';

import 'package:crossfit/fitbit/urls/fitbitActivityTimeseriesAPIURL.dart';

import 'package:crossfit/fitbit/errors/fitbitUnexistentFitbitResourceException.dart';

import 'package:crossfit/fitbit/urls/fitbitAPIURL.dart';

import 'package:crossfit/fitbit/data/fitbitData.dart';
import 'package:crossfit/fitbit/data/fitbitActivityTimeseriesData.dart';

import 'package:crossfit/fitbit/managers/fitbitDataManager.dart';

/// [FitbitActivityTimeseriesDataManager] is a class the manages the requests related to
/// [FitbitActivityTimeseriesData].
class FitbitActivityTimeseriesDataManager extends FitbitDataManager {
  /// The type of activity timeseries data.
  late String type;

  /// Default [FitbitActivityTimeseriesDataManager] constructor.
  FitbitActivityTimeseriesDataManager(
      {required String type,
      required String clientID,
      required String clientSecret})
      : super(
          clientID: clientID,
          clientSecret: clientSecret,
        ) {
    this.type = type;
  }

  @override
  Future<List<FitbitData>> fetch(FitbitAPIURL fitbitUrl) async {
    //Set the resource type
    final fitbitSpecificUrl = fitbitUrl as FitbitActivityTimeseriesAPIURL;
    type = fitbitSpecificUrl.resource;

    // Get the response
    final response = await getResponse(fitbitUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<FitbitData> ret = _extractFitbitActivityTimeseriesData(
        response, fitbitUrl.fitbitCredentials!.userID);
    return ret;
  } // fetch

  /// A private method that extracts [FitbitActivityTimeseriesData] from the given response.
  List<FitbitActivityTimeseriesData> _extractFitbitActivityTimeseriesData(
      dynamic response, String? userID) {
    final data = response[_getDataField()];
    List<FitbitActivityTimeseriesData> atDatapoints =
        List<FitbitActivityTimeseriesData>.empty(growable: true);

    for (var record = 0; record < data.length; record++) {
      atDatapoints.add(FitbitActivityTimeseriesData(
        userID: userID,
        dateOfMonitoring: DateTime.parse(data[record]['dateTime']),
        type: this.type,
        value: double.parse(data[record]['value']),
      ));
    } // for entry
    return atDatapoints;
  } // _extractFitbitActivityTimeseriesData

  /// A private method that returns the data field name of the response.
  String _getDataField() {
    final validTypes = [
      'activityCalories',
      'calories',
      'caloriesBMR',
      'distance',
      'floors',
      'elevation',
      'minutesSedentary',
      'minutesLightlyActive',
      'minutesFairlyActive',
      'minutesVeryActive',
      'steps'
    ];

    if (validTypes.contains(type))
      return 'activities-' + type;
    else {
      throw FitbitUnaexistentFitbitResourceException(
          message: 'The specified resource is not existent.');
    } // else
  } // _getDataField

} // FitbitActivityTimeseriesDataManager
