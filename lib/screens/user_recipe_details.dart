import 'package:flutter/material.dart';
import 'package:nomnomnerds/screenwidgets/userdetailscreen/user_recipe_body.dart';

class UserRecipeDetailsScreen extends StatelessWidget {
  const UserRecipeDetailsScreen({
    super.key,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.instructions,
  });

  final String name, description, cuisine, diet, instructions;
  final int preptime, cooktime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Text('Hello'),
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: Navigator.of(context).pop,
      //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
      //   ),
      //   backgroundColor: Colors.transparent,
      // ),
      body: UserRecipeBody(
        name: name,
        cuisine: cuisine,
        description: description,
        diet: diet,
        preptime: preptime,
        cooktime: cooktime,
        instructions: instructions,
      ),
    );
  }
}
