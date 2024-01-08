import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/models/recipenolist_model.dart';
import 'package:nomnomnerds/screens/details_screen.dart';

class RecommendsRecipe extends StatelessWidget {
  const RecommendsRecipe({
    Key? key,
    required this.userid,
  }) : super(key: key);
  final int userid;

  Future<List<RecommendRecipeCard>> displayRecommendedRecipe(
      BuildContext context, int userid) async {
    List<RecipenolistModel> returned =
        await DatabaseHelper.getRecommendedRecipes(userid);

    List<RecommendRecipeCard> recipeCards = [];
    for (int i = 0; i < returned.length; i++) {
      print(returned[i].image_url);
      recipeCards.add(
        RecommendRecipeCard(
          name: returned[i].recipe_name,
          cuisine: returned[i].cuisine,
          diet: returned[i].diet,
          image: returned[i].image_url,
          description: returned[i].description,
          preptime: returned[i].prep_time,
          cooktime: returned[i].cook_time,
          instructions: returned[i].instructions,
          id: returned[i].recipe_id,
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

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
        top: nDefaultSize,
        bottom: nDefaultSize * 2.2,
      ),
      width: size.width * 0.9,
      height: size.height * 0.4,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<RecommendRecipeCard>>(
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
                  return RecipeCardNavigator(
                    recipeCards: snapshot.data!,
                    userid: userid,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCardNavigator extends StatefulWidget {
  final List<RecommendRecipeCard> recipeCards;

  RecipeCardNavigator({required this.recipeCards, required this.userid});
  final int userid;
  @override
  _RecipeCardNavigatorState createState() =>
      _RecipeCardNavigatorState(userid: userid);
}

class _RecipeCardNavigatorState extends State<RecipeCardNavigator> {
  int currentIndex = 0;
  _RecipeCardNavigatorState({required this.userid});
  final int userid;
  void showPreviousRecipe() {
    setState(() {
      currentIndex = (currentIndex - 1) % widget.recipeCards.length;
      if (currentIndex < 0) {
        currentIndex = widget.recipeCards.length - 1;
      }
    });
  }

  void showNextRecipe() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.recipeCards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size.width * 0.9,
              height: size.height * 0.4,
              child: GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        uid: userid,
                        id: widget.recipeCards[currentIndex].id,
                        name: widget.recipeCards[currentIndex].name,
                        description:
                            widget.recipeCards[currentIndex].description,
                        cuisine: widget.recipeCards[currentIndex].cuisine,
                        diet: widget.recipeCards[currentIndex].diet,
                        preptime: widget.recipeCards[currentIndex].preptime,
                        cooktime: widget.recipeCards[currentIndex].cooktime,
                        instructions:
                            widget.recipeCards[currentIndex].instructions,
                        image: widget.recipeCards[currentIndex].image,
                      ),
                    ),
                  );
                },
                onTap: showPreviousRecipe,
                child: widget.recipeCards[currentIndex],
              ),
            ),
            Positioned(
              top: 15,
              right: 10,
              child: GestureDetector(
                onTap: showNextRecipe,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RecommendRecipeCard extends StatelessWidget {
  const RecommendRecipeCard({
    Key? key,
    required this.id,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.instructions,
    required this.image,
    required this.press,
  }) : super(key: key);

  final int id;
  final String name, cuisine, diet, description, instructions, image;
  final int preptime, cooktime;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.4,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black
                        .withOpacity(0.1), // Adjust the opacity as needed
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: size.width * 0.9,
                    height: size.height * 0.4,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name".toUpperCase(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 236, 232, 224),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$cuisine".toLowerCase(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 22,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$diet".toLowerCase(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 18,
                    ),
                    Text(
                      " Prep: ${preptime} min | Cook: ${cooktime} min",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
