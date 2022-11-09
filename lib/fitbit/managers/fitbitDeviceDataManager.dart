import 'package:logger/logger.dart';

import 'package:crossfit/fitbit/data/fitbitDeviceData.dart';

import 'package:crossfit/fitbit/urls/fitbitAPIURL.dart';

import 'package:crossfit/fitbit/data/fitbitData.dart';

import 'package:crossfit/fitbit/managers/fitbitDataManager.dart';

/// [FitbitDeviceDataManager] is a class the manages the requests related to
/// [FitbitDeviceData].
class FitbitDeviceDataManager extends FitbitDataManager {
  /// Default constructor
  FitbitDeviceDataManager(
      {required String clientID, required String clientSecret})
      : super(
          clientID: clientID,
          clientSecret: clientSecret,
        );

  @override
  Future<List<FitbitData>> fetch(FitbitAPIURL fitbitUrl) async {
    // Get the response
    final response = await getResponse(fitbitUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<FitbitData> ret =
        _extractFitbitDeviceData(response, fitbitUrl.fitbitCredentials!.userID);
    return ret;
  } // fetch

  /// A private method that extracts [FitbitDeviceData] from the given response.
  List<FitbitDeviceData> _extractFitbitDeviceData(
      dynamic response, String? userID) {
    final data = response;
    List<FitbitDeviceData> deviceDatapoints =
        List<FitbitDeviceData>.empty(growable: true);

    for (var record = 0; record < data.length; record++) {
      deviceDatapoints.add(FitbitDeviceData(
        userID: userID,
        batteryLevel: data[record]['battery'],
        deviceId: data[record]['id'],
        deviceVersion: data[record]['deviceVersion'],
        type: data[record]['type'],
        lastSyncTime: DateTime.parse(data[record]['lastSyncTime']),
      ));
    } // for entry
    return deviceDatapoints;
  } // _extractFitbitDeviceData

} // FitbitDeviceDataManager
