class UserRecipeModel {
  int userid;
  int? recipe_id;
  String recipe_name;
  String description;
  String cuisine;
  String diet;
  int prep_time;
  int cook_time;
  String instructions;

  UserRecipeModel({
    required this.userid,
    int? recipe_id,
    required this.recipe_name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.prep_time,
    required this.cook_time,
    required this.instructions,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //     userid: json['userid'],
  //     username: json['username'],
  //     email: json['email'],
  //     password: json['password']);

  Map<String, dynamic> toMap() => {
        'userid': userid,
        'recipe_id': recipe_id,
        'recipe_name': recipe_name,
        'description': description,
        'cuisine': cuisine,
        'diet': diet,
        'prep_time': prep_time,
        'cook_time': cook_time,
        'instructions': instructions,
      };
}
