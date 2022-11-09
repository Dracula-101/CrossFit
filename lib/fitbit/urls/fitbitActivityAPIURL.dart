import 'package:crossfit/fitbit/fitbitConnector.dart';
import 'package:crossfit/fitbit/urls/fitbitAPIURL.dart';

import 'package:crossfit/fitbit/utils/formats.dart';

import 'package:crossfit/fitbit/data/fitbitActivityData.dart';

/// [FitbitActivityAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Fitbit Web APIs urls to fetch
/// [FitbitActivityData].
class FitbitActivityAPIURL extends FitbitAPIURL {
  /// Default [FitbitActivityAPIURL] constructor.
  FitbitActivityAPIURL(
      {required String url, required FitbitCredentials? fitbitCredentials})
      : super(fitbitCredentials: fitbitCredentials, url: url);

  /// Generates a [FitbitActivityAPIURL] to get [FitbitActivityData] of a
  /// specific day [date] and credentials [fitbitCredentials].
  factory FitbitActivityAPIURL.day(
      {required FitbitCredentials fitbitCredentials, required DateTime date}) {
    String dateStr = Formats.onlyDayDateFormatTicks.format(date);
    return FitbitActivityAPIURL(
      url:
          '${_getBaseURL(fitbitCredentials.userID)}?beforeDate=$dateStr&sort=asc&limit=30&offset=0',
      fitbitCredentials: fitbitCredentials,
    );
  } // FitbitActivityAPIURL.day

  static String _getBaseURL(String? userID) {
    return 'https://api.fitbit.com/1/user/$userID/activities/list.json';
  } // _getBaseURL

} // FitbitActivityTimeseriesAPIURL
