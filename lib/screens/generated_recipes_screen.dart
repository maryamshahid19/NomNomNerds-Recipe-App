import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/models/recipenolist_model.dart';
import 'package:nomnomnerds/screens/details_screen.dart';

class GeneratedRecipe extends StatelessWidget {
  GeneratedRecipe({
    Key? key,
    required this.userid,
    required this.ingredients,
  }) : super(key: key);
  final int userid;
  final List<String> ingredients;

  Future<List<GeneratedRecipeCard>> displayGeneratedRecipe(
      BuildContext context, int userid) async {
    // List<RecipenolistModel> returned =
    //     await DatabaseHelper.getHealthyOptions(userid);
    List<RecipenolistModel> returned =
        await DatabaseHelper.getGeneratedRecipes(ingredients);
    List<GeneratedRecipeCard> recipeCards = [];
    for (int i = 0; i < returned.length; i++) {
      recipeCards.add(
        GeneratedRecipeCard(
          name: returned[i].recipe_name,
          description: returned[i].description,
          cuisine: returned[i].cuisine,
          diet: returned[i].diet,
          preptime: returned[i].prep_time,
          cooktime: returned[i].cook_time,
          instructions: returned[i].instructions,
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
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.02,
          left: size.width * 0.05,
          right: size.width * 0.04,
          bottom: size.height * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Recipes according to",
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 251, 149, 106),
                //color: Color.fromARGB(255, 251, 149, 106),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "Available Items",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder<List<GeneratedRecipeCard>>(
                      future: displayGeneratedRecipe(context, userid),
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

class GeneratedRecipeCard extends StatelessWidget {
  const GeneratedRecipeCard({
    Key? key,
    required this.name,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.image,
    required this.press,
    required this.instructions,
    required this.description,
  }) : super(key: key);

  final String name, cuisine, diet, instructions, description, image;
  final int preptime, cooktime;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Text(
          "$name".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(
            top: nDefaultSize * 0.3,
            left: nDefaultSize * 0.05,
            right: nDefaultSize * 0.05,
            bottom: nDefaultSize * 0.3,
          ),
          width: size.width * 0.9, // Adjust as needed
          height: size.height * 0.4, // Adjust as needed

          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                child: Container(
                  width: size.width * 0.9, // Adjust as needed
                  height: size.height * 0.4 -
                      size.height * 0.10, // Adjust as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), // Circular border
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: size.width * 0.05,
                right: size.width * 0.05,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 251, 149, 106),
                      borderRadius:
                          BorderRadius.circular(20), // Circular border
                    ),
                    padding: EdgeInsets.all(15),
                    width: size.width * 0.8, // Adjust as needed
                    height: size.height * 0.16, // Adjust as needed
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            // overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "$preptime min | $cooktime min\n\n"
                                      .toLowerCase(),
                                  style: TextStyle(
                                    color: Colors.white70, // Changed to black
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: "$description\n\n",
                                  style: TextStyle(
                                    color: Colors.white, // Changed to black
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: size.width * 0.01,
                child: InkWell(
                  onTap: press,
                  child: Container(
                    // width: size.width * 0.14, // Adjust as needed
                    // height: size.height * 0.2, // Adjust as needed
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)), // Circular border
                        color: Colors
                            .transparent // Background color of the icon container
                        ),
                    // child: IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.favorite,
                    //     size: 25,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: press,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
