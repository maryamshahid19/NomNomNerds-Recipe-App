import 'dart:ui';

import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:flutter/material.dart';
import 'package:nomnomnerds/screenwidgets/detailscreen/recipe_details.dart';
//import 'package:nomnomnerds/screenwidgets/detailscreen/body.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.userid,
    required this.id,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.instructions,
    required this.image,
  });

  final String name, description, cuisine, diet, instructions, image;
  final int userid, id, preptime, cooktime;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkfavt(widget.userid, widget.id); // Check the favorite status initially
  }

  void _checkfavt(int userid, int recipe_id) async {
    if (await DatabaseHelper.checkFavt(userid, recipe_id)) {
      // If the recipe is a favorite, set isFavorite to true
      setState(() {
        isFavorite = true;
      });
    }
  }

  void toggleFavorite(int userid) async {
    bool updatedFavorite = !isFavorite;

    if (updatedFavorite) {
      print("check1");
      await DatabaseHelper.saveUserFavorites(userid, widget.id);
    } else {
      await DatabaseHelper.dropFavtRecipe(userid, widget.id);
      print("check2");
    }

    setState(() {
      isFavorite = updatedFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: size.width * 0.12,
              left: size.width * 0.08,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: size.width * 0.12,
              right: size.width * 0.08,
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  toggleFavorite(widget.userid);
                },
              ),
            ),
            Positioned(
              bottom: size.height * 0.07,
              right: (size.width - size.width * 0.8) / 2,
              child: SizedBox(
                height: size.height * 0.55,
                width: size.width * 0.8,
                child: ClipRect(
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color.fromARGB(255, 191, 188, 188)
                              .withOpacity(0.4)),
                      child: RecipeDetails(
                        id: widget.id,
                        name: widget.name,
                        cuisine: widget.cuisine,
                        description: widget.description,
                        diet: widget.diet,
                        instructions: widget.instructions,
                        preptime: widget.preptime,
                        cooktime: widget.cooktime,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
