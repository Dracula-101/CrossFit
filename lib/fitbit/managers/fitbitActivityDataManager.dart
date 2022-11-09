import 'package:logger/logger.dart';

import 'package:crossfit/fitbit/urls/fitbitAPIURL.dart';

import 'package:crossfit/fitbit/data/fitbitData.dart';
import 'package:crossfit/fitbit/data/fitbitActivityData.dart';

import 'package:crossfit/fitbit/managers/fitbitDataManager.dart';

/// [FitbitActivityDataManager] is a class the manages the requests related to
/// [FitbitActivityData].
class FitbitActivityDataManager extends FitbitDataManager {
  /// Default [FitbitActivityDataManager] constructor.
  FitbitActivityDataManager(
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
    List<FitbitData> ret = [];

    ret.add(FitbitActivityData.fromJson(response));
    return ret;
  } // fetch

} // FitbitActivityDataManager
