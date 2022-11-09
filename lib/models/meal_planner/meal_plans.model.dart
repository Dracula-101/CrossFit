class MealTemplateDay {
  List<Meals>? meals;
  Nutrients? nutrients;

  MealTemplateDay({this.meals, this.nutrients});

  MealTemplateDay.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
    nutrients = json['nutrients'] != null
        ? Nutrients.fromJson(json['nutrients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    if (nutrients != null) {
      data['nutrients'] = nutrients!.toJson();
    }
    return data;
  }
}

class Meals {
  int? id;
  String? title;
  String? imageType;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;

  Meals(
      {this.id,
      this.title,
      this.imageType,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageType = json['imageType'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imageType'] = imageType;
    data['readyInMinutes'] = readyInMinutes;
    data['servings'] = servings;
    data['sourceUrl'] = sourceUrl;
    return data;
  }
}

class Nutrients {
  double? calories;
  double? carbohydrates;
  double? fat;
  double? protein;

  Nutrients({this.calories, this.carbohydrates, this.fat, this.protein});

  Nutrients.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbohydrates = json['carbohydrates'];
    fat = json['fat'];
    protein = json['protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calories'] = calories;
    data['carbohydrates'] = carbohydrates;
    data['fat'] = fat;
    data['protein'] = protein;
    return data;
  }
}

class MealTemplateWeek {
  Week? week;

  MealTemplateWeek({this.week});

  MealTemplateWeek.fromJson(Map<String, dynamic> json) {
    week = json['week'] != null ? Week.fromJson(json['week']) : null;
  }
}

class Week {
  List<Days>? days;

  Week({this.days});

  Week.fromJson(Map<String, dynamic> json) {
    days = <Days>[];
    if (json['monday'] != null) {
      days?.add(Days.fromJson(json['monday']));
    }
    if (json['tuesday'] != null) {
      days?.add(Days.fromJson(json['tuesday']));
    }
    if (json['wednesday'] != null) {
      days?.add(Days.fromJson(json['wednesday']));
    }
    if (json['thursday'] != null) {
      days?.add(Days.fromJson(json['thursday']));
    }
    if (json['friday'] != null) {
      days?.add(Days.fromJson(json['friday']));
    }
    if (json['saturday'] != null) {
      days?.add(Days.fromJson(json['saturday']));
    }
    if (json['sunday'] != null) {
      days?.add(Days.fromJson(json['sunday']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  List<Meals>? meals;
  Nutrients? nutrients;

  Days({this.meals, this.nutrients});

  Days.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
    nutrients = json['nutrients'] != null
        ? Nutrients.fromJson(json['nutrients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    if (nutrients != null) {
      data['nutrients'] = nutrients!.toJson();
    }
    return data;
  }
}
