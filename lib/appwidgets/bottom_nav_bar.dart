import 'package:flutter/material.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/models/user_recipe_model.dart';
import 'package:nomnomnerds/screens/home_screen.dart';
import 'package:nomnomnerds/screens/recipe_generator_screen.dart';
import 'package:nomnomnerds/screens/upload_recipe_screen.dart';
import 'package:nomnomnerds/screens/user_profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.username, required this.userid});

  final String username;
  final int userid;

  //yeh function user ki added recipes ko get kar raha hai DB se
  Future<List<UserRecipeModel>> useraddedrecipes(int userid) async {
    print("check1");
    List<UserRecipeModel> returned =
        await DatabaseHelper.getUserRecipes(userid);
    return returned;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: nDefaultSize * 2,
        right: nDefaultSize * 2,
      ),
      height: 50,
      decoration: BoxDecoration(
        //color: Color.fromARGB(255, 244, 166, 57),
        color: Color.fromARGB(255, 251, 149, 106),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 237, 229, 229),
              size: 28,
            ),
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
          ),
          IconButton(
            icon: Icon(
              Icons.soup_kitchen_rounded,
              color: Color.fromARGB(255, 237, 229, 229),
              size: 29,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeGeneratorScreen(userid: userid),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Color.fromARGB(255, 237, 229, 229),
              size: 26,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadRecipeScreen(
                    userid: userid,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 237, 229, 229),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(userid: userid, username: username)),
              );
            },
          )
        ],
      ),
    );
  }
}
