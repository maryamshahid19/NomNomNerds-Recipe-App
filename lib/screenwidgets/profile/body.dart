import 'package:nomnomnerds/appwidgets/bottom_nav_bar.dart';
import 'package:nomnomnerds/models/recipenolist_model.dart';
import 'package:nomnomnerds/screenwidgets/profile/profile_pic.dart';
import 'package:nomnomnerds/screens/welcome_screen.dart';
import 'profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:nomnomnerds/screens/user_recipe_screen.dart';
import 'package:nomnomnerds/screens/favorites_screen.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/models/user_recipe_model.dart';

class Body extends StatelessWidget {
  Body({Key? key, required this.userid, required this.username})
      : super(key: key);
  final int userid;
  final String username;

  Future<int> displayUserUploadedRecipe(
      BuildContext context, int userid) async {
    List<UserRecipeModel> returned =
        await DatabaseHelper.getUserRecipes(userid);

    int l = returned.length;
    return l;
  }

  Future<int> displayUserFavoriteRecipe(
      BuildContext context, int userid) async {
    List<RecipenolistModel> returned =
        await DatabaseHelper.getUserFavorites(userid);

    int l = returned.length;
    return l;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, 20, size.width * 0.1, 10),
                color: Color.fromARGB(255, 251, 149, 106),
                child: Column(
                  children: [
                    ProfilePic(),
                    SizedBox(height: 8),
                    Text("$username",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400)),
                    SizedBox(height: 20),
                    Container(
                      width: size.width * 0.5,
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder<int>(
                              future:
                                  displayUserUploadedRecipe(context, userid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  int uploadedCount = snapshot.data ?? 0;
                                  return Column(
                                    children: [
                                      Text(
                                        "$uploadedCount",
                                        style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 0),
                                      Text(
                                        "Uploaded",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            Spacer(),
                            FutureBuilder<int>(
                              future:
                                  displayUserFavoriteRecipe(context, userid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  int favoriteCount = snapshot.data ?? 0;
                                  return Column(
                                    children: [
                                      Text(
                                        "$favoriteCount",
                                        style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 0),
                                      Text(
                                        "Favorites",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.15,
                size.height * 0.05,
                size.width * 0.15,
                size.height * 0.05,
              ),
              width: size.width,
              height: size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileMenu(
                      text: "Uploaded Recipes",
                      icon: Icon(Icons.upload_file),
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserRecipeScreen(userid: userid),
                          ),
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Favourite Recipes",
                      icon: Icon(Icons.favorite),
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritesScreen(
                                userid: userid, username: username),
                          ),
                        );
                      },
                    ),
                    ProfileMenu(
                        text: "Log Out",
                        icon: Icon(Icons.logout),
                        press: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                        }
                        //},
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(username: username, userid: userid),
    );
  }
}
