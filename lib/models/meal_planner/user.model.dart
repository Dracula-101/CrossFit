class UserModel {
  String? username;
  String? spoonacularPassword;
  String? hash;

  UserModel({this.username, this.spoonacularPassword, this.hash});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    spoonacularPassword = json['spoonacularPassword'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['spoonacularPassword'] = spoonacularPassword;
    data['hash'] = hash;
    return data;
  }
}
