import 'package:flutter/material.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/screenwidgets/homescreen/recommend_recipes.dart';
import 'package:nomnomnerds/screenwidgets/homescreen/preferredDiet_recipes.dart';
import 'package:nomnomnerds/screenwidgets/homescreen/featured_recipes.dart';
//import 'package:plant_app/constants.dart';

//import 'featurred_plants.dart';
import 'package:nomnomnerds/screenwidgets/homescreen/header.dart';
//import 'recomend_plants.dart';
import 'title.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.username,
    required this.userid,
  });

  final String username;
  final int userid;
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    //print("Checking userid $userid");
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(
            size: size,
            username: username,
            userid: userid,
          ),
          TitleWithCustomUnderline(text: "Recommended"),
          RecommendsRecipe(userid: userid),
          TitleWithCustomUnderline(text: "Healthy Options"),
          PreferredDietRecipe(userid: userid),
          TitleWithCustomUnderline(text: "Recipes You May Like"),
          FeaturedRecipe(userid: userid),
          SizedBox(height: nDefaultSize),
        ],
      ),
    );
  }
}
