class Exercise {
  final String title, time, difficult, image;

  Exercise({
    required this.title,
    required this.time,
    required this.difficult,
    required this.image,
  });
}
class Workouts {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  Workouts({this.count, this.next, this.previous, this.results});

  Workouts.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? uuid;
  String? name;
  int? exerciseBase;
  String? creationDate;
  int? category;
  List<int>? muscles;
  List<int>? musclesSecondary;
  List<int>? equipment;
  int? language;
  int? license;
  String? licenseAuthor;
  List<int>? variations;
  List<String>? authorHistory;

  Results(
      {this.id,
      this.uuid,
      this.name,
      this.exerciseBase,
      this.creationDate,
      this.category,
      this.muscles,
      this.musclesSecondary,
      this.equipment,
      this.language,
      this.license,
      this.licenseAuthor,
      this.variations,
      this.authorHistory});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    exerciseBase = json['exercise_base'];
    creationDate = json['creation_date'];
    category = json['category'];
    muscles = json['muscles'].cast<int>();
    musclesSecondary = json['muscles_secondary'].cast<int>();
    equipment = json['equipment'].cast<int>();
    language = json['language'];
    license = json['license'];
    licenseAuthor = json['license_author'];
    variations = json['variations'].cast<int>();
    authorHistory = json['author_history'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['exercise_base'] = exerciseBase;
    data['creation_date'] = creationDate;
    data['category'] = category;
    data['muscles'] = muscles;
    data['muscles_secondary'] = musclesSecondary;
    data['equipment'] = equipment;
    data['language'] = language;
    data['license'] = license;
    data['license_author'] = licenseAuthor;
    data['variations'] = variations;
    data['author_history'] = authorHistory;
    return data;
  }
}
