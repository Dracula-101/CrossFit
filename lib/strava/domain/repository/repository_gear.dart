import 'package:crossfit/strava/domain/model/model_gear.dart';

abstract class RepositoryGear {
  Future<Gear> getGear(int gearId);
}
