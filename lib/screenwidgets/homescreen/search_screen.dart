// import 'package:flutter/material.dart';
// import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
// import 'package:nomnomnerds/constants/sizes_strings.dart';
// import 'package:nomnomnerds/models/recipenolist_model.dart';

// class SearchScreen extends StatelessWidget {
//   SearchScreen({super.key, required this.searched});
//   final String searched;

//   Future<List<RecipenolistModel>> search(String searched) async {
//     print("check1");
//     List<RecipenolistModel> returned =
//         await DatabaseHelper.getRecipesfromSearch(searched);
//     print(returned[0].recipe_name);
//     return returned;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _conSearch = TextEditingController();
//     print("check200");
//     search(searched);
//     return Scaffold();
//   }
// }
