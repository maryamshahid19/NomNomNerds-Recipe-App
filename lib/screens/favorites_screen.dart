import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/models/recipenolist_model.dart';
import 'package:nomnomnerds/screens/details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key, required this.userid}) : super(key: key);
  final int userid;

  Future<List<RecipenolistModel>> search(int userid) async {
    print("check1");
    // List<RecipenolistModel> returned =
    //     await DatabaseHelper.getRecipesfromSearchviaIngredients(searched);
    List<RecipenolistModel> returned =
        await DatabaseHelper.getUserFavorites(userid);
    return returned;
  }

  Future<List<FavoritesRecipeCard>> displayFavoriteRecipe(
      BuildContext context, int userid) async {
    List<RecipenolistModel> returned =
        await search(userid); //yahan use hoga favorites ka

    List<FavoritesRecipeCard> recipeCards = [];
    for (int i = 0; i < returned.length; i++) {
      recipeCards.add(
        FavoritesRecipeCard(
          name: returned[i].recipe_name,
          cuisine: returned[i].cuisine,
          diet: returned[i].diet,
          preptime: returned[i].prep_time,
          cooktime: returned[i].cook_time,
          image: returned[i].image_url,
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                uid: userid,
                id: returned[i].recipe_id,
                name: returned[i].recipe_name,
                description: returned[i].description,
                cuisine: returned[i].cuisine,
                diet: returned[i].diet,
                preptime: returned[i].prep_time,
                cooktime: returned[i].cook_time,
                instructions: returned[i].instructions,
                image: returned[i].image_url,
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
            )),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: size.width * 0.05,
            right: size.width * 0.05),
        child: Column(
          children: [
            // SizedBox(
            //   height: 2,
            // ),
            Text(
              "Your Favorite Recipes",
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder<List<FavoritesRecipeCard>>(
                      future: displayFavoriteRecipe(context, userid),
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

class FavoritesRecipeCard extends StatelessWidget {
  const FavoritesRecipeCard({
    Key? key,
    required this.name,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name, cuisine, diet, image;
  final int preptime, cooktime;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        top: nDefaultSize * 0.5,
        bottom: nDefaultSize * 0.5,
      ),
      width: size.width * 0.9,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 251, 149, 106),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: size.width * 0.35,
            height: size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: press,
              child: Container(
                padding: EdgeInsets.all(25),
                width: size.width * 0.55,
                height: size.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        color: Color.fromARGB(231, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1, // Adjust the number of lines as needed
                    ),
                    SizedBox(height: 10),
                    Text(
                      diet.toLowerCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "$preptime min | $cooktime min".toLowerCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
