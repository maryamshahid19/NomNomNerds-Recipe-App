import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/screens/generated_recipes_screen.dart';
import 'package:nomnomnerds/screens/home_screen.dart';

class RecipeGeneratorScreen extends StatefulWidget {
  const RecipeGeneratorScreen({
    Key? key,
    required this.userid,
    required this.username,
  }) : super(key: key);

  final int userid;
  final String username;

  @override
  State<RecipeGeneratorScreen> createState() =>
      _RecipeGeneratorScreenState(userid: userid, username: username);
}

class _RecipeGeneratorScreenState extends State<RecipeGeneratorScreen> {
  _RecipeGeneratorScreenState({
    required this.userid,
    required this.username,
  });

  List<String> ingredientNames = [];
  List<String> selectedIngredients = []; // Keep track of selected ingredients
  final int userid;
  final String username;

  @override
  void initState() {
    super.initState();
    loadIngredientNames();
  }

  Future<void> loadIngredientNames() async {
    List<String> names = await DatabaseHelper.getIngredientNames();
    setState(() {
      selectedIngredients.clear();
      ingredientNames.clear();
      ingredientNames = names;
    });
  }

  AlertDialog showAlertDialog(String message) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          message,
        ),
      ),
      contentTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:
              Text("Ok", style: TextStyle(color: Colors.white70, fontSize: 20)),
        ),
      ],
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
    );
  }

  AlertDialog showAlertDialog2(String message) {
    print(selectedIngredients);
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          message,
        ),
      ),
      contentTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GeneratedRecipe(
                    userid: userid,
                    username: username,
                    ingredients: selectedIngredients),
              ),
            );
          },
          child:
              Text("Ok", style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
      ],
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  username: username,
                  userid: userid,
                ),
              ),
            );
            //iss ko home se kuch aur karo homescreen par home ka button kiun dia hua hai
            //print("checking getuserrecipe $userid");
            //List<UserRecipeModel> returned = await useraddedrecipes(userid);
            //print(returned[0].recipe_name);
          },
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text(
          'Select Ingredients',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ingredientNames.isEmpty
            ? Center(
                child: Text('No ingredients available.'),
              )
            : ListView.builder(
                itemCount: ingredientNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 251, 149, 106),
                      child: Icon(
                        Icons.food_bank_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(ingredientNames[index]),
                    onTap: () {
                      // Toggle the selection of the ingredient
                      setState(() {
                        if (selectedIngredients
                            .contains(ingredientNames[index])) {
                          selectedIngredients.remove(ingredientNames[index]);
                        } else {
                          selectedIngredients.add(ingredientNames[index]);
                        }
                      });
                    },
                    trailing:
                        selectedIngredients.contains(ingredientNames[index])
                            ? Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 251, 149, 106),
                              )
                            : Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.grey,
                              ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Check if at least 1 ingredient is selected
          if (selectedIngredients.isEmpty) {
            showDialog(
              context: context,
              builder: (context) =>
                  showAlertDialog("Select at least 1 ingredient"),
            );
          } else {
            // Continue with your logic for selected ingredients
            showDialog(
              context: context,
              builder: (context) => showAlertDialog2("Ingredients Selected"),
            );
          }
        },
        child: Text("Select"),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}





// Your getIngredientNames function
