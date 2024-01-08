import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/models/user_recipe_model.dart';
import 'package:nomnomnerds/screens/user_recipe_details.dart';

class UserRecipeScreen extends StatelessWidget {
  UserRecipeScreen({Key? key, required this.userid}) : super(key: key);
  final int userid;

  Future<List<UserRecipeCard>> displayUserUploadedRecipe(
      BuildContext context, int userid) async {
    List<UserRecipeModel> returned =
        await DatabaseHelper.getUserRecipes(userid);

    List<UserRecipeCard> recipeCards = [];
    for (int i = 0; i < returned.length; i++) {
      recipeCards.add(
        UserRecipeCard(
          name: returned[i].recipe_name,
          cuisine: returned[i].cuisine,
          diet: returned[i].diet,
          preptime: returned[i].prep_time,
          cooktime: returned[i].cook_time,
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserRecipeDetailsScreen(
                name: returned[i].recipe_name,
                description: returned[i].description,
                cuisine: returned[i].cuisine,
                diet: returned[i].diet,
                preptime: returned[i].prep_time,
                cooktime: returned[i].cook_time,
                instructions: returned[i].instructions,
              ),
            ),
          ),
        ),
      );
    }
    return recipeCards;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: 50,
            bottom: 30,
            left: size.width * 0.05,
            right: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 2,
            // ),
            Column(
              children: [
                Text(
                  "Your Recipes",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder<List<UserRecipeCard>>(
                      future: displayUserUploadedRecipe(context, userid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Text("Loading"),
                          );
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Container(
                            child: Text("No recipes found"),
                          );
                        } else {
                          return Column(
                            children: snapshot.data!,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRecipeCard extends StatelessWidget {
  const UserRecipeCard({
    Key? key,
    required this.name,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.press,
  }) : super(key: key);

  final String name, cuisine, diet;
  final int preptime, cooktime;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: nDefaultSize * 0.5,
            bottom: nDefaultSize * 0.5,
          ),
          width: size.width * 0.9,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white, // Set the box color to white
            // border: Border.all(
            //   color: Color.fromARGB(255, 251, 149, 106), // Set the border color
            //   width: 2, // Set the border width as needed
            // ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: press,
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.3,
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/rimg1.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width * 0.55,
                        height: size.height * 0.15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                color: const Color.fromARGB(210, 0, 0, 0),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines:
                                  1, // Adjust the number of lines as needed
                            ),
                            Text(
                              diet.toLowerCase(),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "$preptime min | $cooktime min".toLowerCase(),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color.fromARGB(
              255, 251, 149, 106), // Set the color of the separation line
          thickness: 2, // Set the thickness of the separation line
        ),
      ],
    );
  }
}
