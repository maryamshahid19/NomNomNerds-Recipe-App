class RecipeIngredients {
  List<int> recipe_id;
  List<int> ing_id;

  RecipeIngredients({
    required this.recipe_id,
    required this.ing_id,
  });

  factory RecipeIngredients.fromJson(Map<String, dynamic> json) =>
      RecipeIngredients(recipe_id: json['recipe_id'], ing_id: json['ing_id']);

  Map<String, dynamic> toMap() => {
        //      'ing_id': ing_id,
        //      'recipe_id': recipe_id,
      };
}
