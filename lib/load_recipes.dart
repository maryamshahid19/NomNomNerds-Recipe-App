// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
// import 'package:nomnomnerds/screens/welcome_screen.dart';
// import 'package:nomnomnerds/constants/image_strings.dart';
// import 'package:nomnomnerds/constants/sizes_strings.dart';
// import 'package:nomnomnerds/constants/text_strings.dart';
// import 'package:csv/csv.dart';
// import 'package:flutter/services.dart';
// import 'package:nomnomnerds/models/recipes_model.dart';
// import 'package:nomnomnerds/screens/signup_screen.dart';

// class LoadRecipes extends StatefulWidget {
//   const LoadRecipes({super.key});

//   @override
//   State<LoadRecipes> createState() => _LoadRecipesState();
// }

// class _LoadRecipesState extends State<LoadRecipes> {
//   bool animate = false;

//   List<List<dynamic>> _data = [];
//   String? choosenvalue;
//   //List<dynamic> categories = [];
//   List<int> recipe_id = [];
//   List<String> recipe_name = [];
//   List<Text> description = [];
//   List<String> cuisine = [];
//   List<String> diet = [];
//   List<int> prep_time = [];
//   List<int> cook_time = [];
//   List<Text> instructions = [];

//   var dbHelper;
//   void _loadrecipes() async {
//     final _rawData =
//         await rootBundle.loadString("assets/csv_files/Recipes.csv");

//     List<List<dynamic>> _listData =
//         const CsvToListConverter().convert(_rawData);
//     setState(() {
//       _data = _listData;
//       //   print(_data[0][0].toString());
//     });
//     //recipes.clear();
//     // isSelected.clear();
//     for (int i = 1; i < _data.length; i++) {
//       recipe_id.add(_data[i][0].toInt());
//       recipe_name.add(_data[i][1].toString());
//       description.add(_data[i][2].toText());
//       cuisine.add(_data[i][3].toString());
//       diet.add(_data[i][4].toString());
//       prep_time.add(_data[i][5].toInt());
//       cook_time.add(_data[i][6].toInt());
//       instructions.add(_data[i][7].toText());
//       //  isSelected.add(false);
//       // print("$categories[i] and $isSelected[i]\n");
//     }
//     // List<String> cats = [
//     //   categories[choice[0]],
//     //   categories[choice[1]],
//     //   categories[choice[2]],
//     //   categories[choice[3]],
//     //   categories[choice[4]],
//     // ];
//     // print(cats);

//     RecipeModel rm = RecipeModel(
//         recipe_id: recipe_id,
//         recipe_name: recipe_name,
//         description: description,
//         cuisine: cuisine,
//         diet: diet,
//         prep_time: prep_time,
//         cook_time: cook_time,
//         instructions: instructions);
//     // UserModel um = UserModel(
//     //   userid: uid,
//     //   username: uname,
//     //   email: email,
//     //   password: pass,
//     // );
//     //print("a2");
//     await DatabaseHelper.saveRecipes(rm);
//     // //   print(categories.length);
//     // // print("Check2");
//     // // print("Check3");
//     // print(counter);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var refresh = FloatingActionButton(
//       child: const Icon(Icons.refresh_outlined),
//       onPressed: _loadrecipes,
//     );
//     return Scaffold(
//       floatingActionButton: Row(
//         children: [
//           SizedBox(
//             width: 5,
//           ),
//           refresh,
//           Spacer(),
//           ElevatedButton(
//             style: ButtonStyle(
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//               ),
//               foregroundColor: MaterialStatePropertyAll(
//                 Color.fromARGB(255, 249, 246, 246),
//               ),
//               backgroundColor: MaterialStatePropertyAll(
//                 Color.fromARGB(255, 210, 136, 109),
//                 //Color.fromARGB(255, 244, 166, 57),
//               ),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const SignUpScreen(),
//                 ),
//               );
//             },
//             child: Text(
//               nSignup.toUpperCase(),
//               style: TextStyle(
//                 letterSpacing: 3.0,
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       //---additional part starts from here------
//     );
//   }
// }
