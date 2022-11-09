import 'package:crossfit/fitbit/data/fitbitData.dart';

class FitbitActivityData implements FitbitData {
  List<Activities>? activities;
  Pagination? pagination;

  FitbitActivityData({this.activities, this.pagination});

  FitbitActivityData.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(Activities.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  @override
  toJson<T extends FitbitData>() {
    final data = <String, dynamic>{};
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Activities {
  int? activeDuration;
  List<ActivityLevel>? activityLevel;
  String? activityName;
  int? activityTypeId;
  int? calories;
  double? distance;
  String? distanceUnit;
  double? duration;
  bool? hasActiveZoneMinutes;
  String? lastModified;
  int? logId;
  String? logType;
  ManualValuesSpecified? manualValuesSpecified;
  int? originalDuration;
  String? originalStartTime;
  double? pace;
  Source? source;
  double? speed;
  String? startTime;
  int? steps;
  String? tcxLink;

  Activities(
      {this.activeDuration,
      this.activityLevel,
      this.activityName,
      this.activityTypeId,
      this.calories,
      this.distance,
      this.distanceUnit,
      this.duration,
      this.hasActiveZoneMinutes,
      this.lastModified,
      this.logId,
      this.logType,
      this.manualValuesSpecified,
      this.originalDuration,
      this.originalStartTime,
      this.pace,
      this.source,
      this.speed,
      this.startTime,
      this.steps,
      this.tcxLink});

  Activities.fromJson(Map<String, dynamic> json) {
    activeDuration = json['activeDuration'];
    if (json['activityLevel'] != null) {
      activityLevel = <ActivityLevel>[];
      json['activityLevel'].forEach((v) {
        activityLevel!.add(ActivityLevel.fromJson(v));
      });
    }
    activityName = json['activityName'];
    activityTypeId = json['activityTypeId'];
    calories = json['calories'];
    distance = json['distance'];
    distanceUnit = json['distanceUnit'];
    duration = double.tryParse(json['duration'].toString());
    hasActiveZoneMinutes = json['hasActiveZoneMinutes'];
    lastModified = json['lastModified'];
    logId = json['logId'];
    logType = json['logType'];
    manualValuesSpecified = json['manualValuesSpecified'] != null
        ? ManualValuesSpecified.fromJson(json['manualValuesSpecified'])
        : null;
    originalDuration = json['originalDuration'];
    originalStartTime = json['originalStartTime'];
    pace = json['pace'];
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    speed = json['speed'];
    startTime = json['startTime'];
    steps = json['steps'];
    tcxLink = json['tcxLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activeDuration'] = activeDuration;
    if (activityLevel != null) {
      data['activityLevel'] = activityLevel!.map((v) => v.toJson()).toList();
    }
    data['activityName'] = activityName;
    data['activityTypeId'] = activityTypeId;
    data['calories'] = calories;
    data['distance'] = distance;
    data['distanceUnit'] = distanceUnit;
    data['duration'] = duration;
    data['hasActiveZoneMinutes'] = hasActiveZoneMinutes;
    data['lastModified'] = lastModified;
    data['logId'] = logId;
    data['logType'] = logType;
    if (manualValuesSpecified != null) {
      data['manualValuesSpecified'] = manualValuesSpecified!.toJson();
    }
    data['originalDuration'] = originalDuration;
    data['originalStartTime'] = originalStartTime;
    data['pace'] = pace;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['speed'] = speed;
    data['startTime'] = startTime;
    data['steps'] = steps;
    data['tcxLink'] = tcxLink;
    return data;
  }
}

class ActivityLevel {
  int? minutes;
  String? name;

  ActivityLevel({this.minutes, this.name});

  ActivityLevel.fromJson(Map<String, dynamic> json) {
    minutes = json['minutes'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minutes'] = minutes;
    data['name'] = name;
    return data;
  }
}

class ManualValuesSpecified {
  bool? calories;
  bool? distance;
  bool? steps;

  ManualValuesSpecified({this.calories, this.distance, this.steps});

  ManualValuesSpecified.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    distance = json['distance'];
    steps = json['steps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calories'] = calories;
    data['distance'] = distance;
    data['steps'] = steps;
    return data;
  }
}

class Source {
  String? id;
  String? name;
  List<String>? trackerFeatures;
  String? type;
  String? url;

  Source({this.id, this.name, this.trackerFeatures, this.type, this.url});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    trackerFeatures = json['trackerFeatures'].cast<String>();
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['trackerFeatures'] = trackerFeatures;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}

class Pagination {
  String? beforeDate;
  int? limit;
  String? next;
  int? offset;
  String? previous;
  String? sort;

  Pagination(
      {this.beforeDate,
      this.limit,
      this.next,
      this.offset,
      this.previous,
      this.sort});

  Pagination.fromJson(Map<String, dynamic> json) {
    beforeDate = json['beforeDate'];
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beforeDate'] = beforeDate;
    data['limit'] = limit;
    data['next'] = next;
    data['offset'] = offset;
    data['previous'] = previous;
    data['sort'] = sort;
    return data;
  }
}
