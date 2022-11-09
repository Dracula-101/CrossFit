import 'package:crossfit/strava/data/repository/client.dart';
import 'package:crossfit/strava/domain/model/model_gear.dart';
import 'package:crossfit/strava/domain/repository/repository_gear.dart';

class RepositoryGearImpl extends RepositoryGear {
  @override
  Future<Gear> getGear(int gearId) {
    return ApiClient.getRequest(
        endPoint: "/v3/gear/$gearId",
        dataConstructor: (data) =>
            Gear.fromJson(Map<String, dynamic>.from(data)));
  }
}
