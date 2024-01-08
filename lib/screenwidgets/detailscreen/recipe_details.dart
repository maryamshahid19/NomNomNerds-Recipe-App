import 'package:flutter/material.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.instructions,
  });

  final String name, description, cuisine, diet, instructions;
  final int id, preptime, cooktime;

  Future<List<String>> displayIngredients(BuildContext context, int id) async {
    List<String> returned = await DatabaseHelper.getIngredientname(
        await DatabaseHelper.getIngredientID(id));

    return returned;
  }

  // void toggleFavorite() async {
  //   int userId = 1; // Replace with the actual user ID

  //   await DatabaseHelper.saveUserFavorites(userId, id);
  // }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(nDefaultSize),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    //color: const Color.fromARGB(121, 255, 255, 255),
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$diet  |  $cuisine'.toLowerCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    //color: Color.fromARGB(98, 255, 255, 255),
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  '"$description"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    //color: Colors.black54,
                    color: Color.fromARGB(102, 255, 255, 255),
                    // color: Color.fromARGB(159, 0, 0, 0),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'prep time: $preptime min',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'cook time: $cooktime min',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'INGREDIENTS:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromARGB(159, 0, 0, 0),
                    decoration: TextDecoration.underline,
                  ),
                ),
                FutureBuilder(
                  future: displayIngredients(context, id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: Colors.white,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data!.map((item) {
                          return Text(
                            item + '\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'INSTRUCTIONS:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromARGB(159, 0, 0, 0),
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '$instructions',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
