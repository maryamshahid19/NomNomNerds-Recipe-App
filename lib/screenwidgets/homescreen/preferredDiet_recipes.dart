import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/models/recipenolist_model.dart';
import 'package:nomnomnerds/screens/details_screen.dart';

class PreferredDietRecipe extends StatelessWidget {
  const PreferredDietRecipe({
    Key? key,
    required this.userid,
  }) : super(key: key);

  final int userid;

  Future<List<PreferredDietRecipeCard>> displayRecommendedRecipe(
      BuildContext context, int userid) async {
    List<RecipenolistModel> returned =
        await DatabaseHelper.getHealthyOptions(userid);

    List<PreferredDietRecipeCard> recipeCards = [];
    for (int i = 0; i < returned.length; i++) {
      print(returned[i].image_url);
      recipeCards.add(
        PreferredDietRecipeCard(
          name: returned[i].recipe_name,
          cuisine: returned[i].cuisine,
          diet: returned[i].diet,
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FutureBuilder<List<PreferredDietRecipeCard>>(
            future: displayRecommendedRecipe(context, userid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  child: Text("Loading"),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return Container(
                  child: Text("No recipes found"),
                );
              } else {
                return Row(
                  children: snapshot.data!,
                );
              }
            },
          ),
          SizedBox(width: nDefaultSize),
        ],
      ),
    );
  }
}

class PreferredDietRecipeCard extends StatelessWidget {
  const PreferredDietRecipeCard({
    Key? key,
    required this.name,
    required this.cuisine,
    required this.diet,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name, cuisine, diet, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: nDefaultSize,
        top: nDefaultSize / 2,
        bottom: nDefaultSize * 2.2,
      ),
      width: size.width * 0.6,
      height: size.height * 0.38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.6,
            height: (size.height * 0.38) * 0.65,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              width: size.width * 0.6,
              height: ((size.height * 0.38) - (size.height * 0.38) * 0.65),
              padding: EdgeInsets.all(nDefaultSize / 2),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 251, 149, 106),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 50,
                    color: Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 232, 232),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  Text(
                    diet.toLowerCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
