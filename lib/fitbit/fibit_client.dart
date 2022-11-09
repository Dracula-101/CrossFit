import 'package:crossfit/api/constants.dart';
import 'package:crossfit/fitbit/fitbitter.dart';
import 'package:crossfit/fitbit/local_manager.dart';

//recoverd previous code

FitbitCredentials? fitbit;
FitbitActivityTimeseriesDataManager? activityTimeseriesDataManager;
FitbitActivityDataManager? activityDataManager;
FitbitAccountDataManager? accountDataManager;
FitbitDeviceDataManager? deviceDataManager;
FitbitSleepDataManager? sleepDataManager;
FitbitSpO2DataManager? spO2DataManager;
FitbitHeartDataManager? heartDataManager;
FitbitTemperatureSkinDataManager? temperatureSkinDataManager;
FitbitBreathingRateDataManager? breathingRateDataManager;
FitbitCardioScoreDataManager? cardioScoreDataManager;

class FitbitClient {
  static Future<FitbitCredentials> authorize() async {
    // check if there are already credentials stored
    final credentials = await LocalStorageManager.getDetails();
    if (credentials[0] != "" && credentials[1] != "" && credentials[2] != "") {
      return FitbitCredentials(
          userID: credentials[0],
          fitbitAccessToken: credentials[1],
          fitbitRefreshToken: credentials[2]);
    }

    fitbit = await FitbitConnector.authorize(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
      redirectUri: Fitbit.redirectUrl,
      callbackUrlScheme: Fitbit.callbackUrlScheme,
    );
    //save to local manager
    await LocalStorageManager.saveDetails(fitbit?.userID ?? '',
        fitbit?.fitbitAccessToken ?? '', fitbit?.fitbitRefreshToken ?? '');

    return fitbit!;
  }

  static Future<void> deauthorize() async {
    final result = await FitbitConnector.unauthorize(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
      fitbitCredentials: fitbit!,
    );
    await LocalStorageManager.deleteToken();
    return result;
  }

  static Future<FitbitAccountData> getAccountDetails() async {
    final response = await accountDataManager?.fetch(
        FitbitAccountAPIURL.withCredentials(fitbitCredentials: fitbit!));
    return response != null
        ? response.first as FitbitAccountData
        : FitbitAccountData();
  }

  static Future<FitbitDeviceData> getDeviceDetails() async {
    final response = await deviceDataManager
        ?.fetch(FitbitDeviceAPIURL.withCredentials(fitbitCredentials: fitbit!));
    return response != null
        ? response.first as FitbitDeviceData
        : FitbitDeviceData();
  }

  static Future<FitbitActivityData> getActivityDetails() async {
    final response = await activityDataManager?.fetch(FitbitActivityAPIURL.day(
        fitbitCredentials: fitbit!, date: DateTime.now()));
    return response != null
        ? response.first as FitbitActivityData
        : FitbitActivityData();
  }

  static Future<bool> hasToken() async {
    final token = await LocalStorageManager.getToken();
    return token != "";
  }

  static initializeFitbit() {
    activityTimeseriesDataManager = FitbitActivityTimeseriesDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
      type: 'steps',
    );
    activityDataManager = FitbitActivityDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    accountDataManager = FitbitAccountDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    deviceDataManager = FitbitDeviceDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    sleepDataManager = FitbitSleepDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    spO2DataManager = FitbitSpO2DataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    heartDataManager = FitbitHeartDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    temperatureSkinDataManager = FitbitTemperatureSkinDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    breathingRateDataManager = FitbitBreathingRateDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
    cardioScoreDataManager = FitbitCardioScoreDataManager(
      clientID: Fitbit.clientId,
      clientSecret: Fitbit.clientSecret,
    );
  }
}
