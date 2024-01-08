class RecipeModel {
  List<int> recipe_id;
  List<String> recipe_name;
  List<String> description;
  List<String> cuisine;
  List<String> diet;
  List<int> prep_time;
  List<int> cook_time;
  List<String> instructions;
  List<String> image_url;

  RecipeModel({
    required this.recipe_id,
    required this.recipe_name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.prep_time,
    required this.cook_time,
    required this.instructions,
    required this.image_url,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //     userid: json['userid'],
  //     username: json['username'],
  //     email: json['email'],
  //     password: json['password']);

  Map<String, dynamic> toMap() => {
        'recipe_id': recipe_id,
        'recipe_name': recipe_name,
        'description': description,
        'cuisine': cuisine,
        'diet': diet,
        'prep_time': prep_time,
        'cook_time': cook_time,
        'instructions': instructions,
        'image_url': image_url,
      };
}
