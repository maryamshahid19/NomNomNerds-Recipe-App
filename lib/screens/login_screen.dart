// ignore_for_file: unused_import, use_build_context_synchronously

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:nomnomnerds/constants/image_strings.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/constants/text_strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nomnomnerds/models/recipe_ingredient_model.dart';
import 'package:nomnomnerds/screens/generated_recipes_screen.dart';
import 'package:nomnomnerds/screens/home_screen.dart';
import 'package:nomnomnerds/screens/signup_screen.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/models/users_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:nomnomnerds/screens/recipe_generator_screen.dart';
import 'package:nomnomnerds/screens/welcome_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool passwordvisible = true;
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;
  @override
  void initState() {
    super.initState();
    passwordvisible = true;
    dbHelper = DatabaseHelper();
  }

  @override
  void dispose() {
    _conEmail.dispose();
    _conPassword.dispose();
    super.dispose();
  }

  Future<void> _loadRecipeIngredients() async {
    List<List<dynamic>> _datarecipeingredients = [];
    List<int> ing_id = [];
    List<int> recipe_id = [];
    // var dbHelper2;

    // @override
    // void initState() {
    //   super.initState();
    //   dbHelper2 = DatabaseHelper();
    // }

    ing_id.clear();
    recipe_id.clear();
    _datarecipeingredients.clear();
    print("Check1");
    final _rawData =
        await rootBundle.loadString("assets/csv_files/recipe_ingredients3.csv");
    print("check2");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _datarecipeingredients = _listData;
      print(_datarecipeingredients.length);
      print("check3");
    });

    for (int i = 1; i < _datarecipeingredients.length; i++) {
      recipe_id.add(_datarecipeingredients[i][0].toInt());
      //print(recipe_id[i]);
      ing_id.add(_datarecipeingredients[i][1].toInt());
      //print(ing_id[i]);
    }

    RecipeIngredients rim =
        RecipeIngredients(recipe_id: recipe_id, ing_id: ing_id);
    await DatabaseHelper.saveRecipeIngredients(rim);
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    // Call your function here
    _loadRecipeIngredients();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Login() async {
    String email = _conEmail.text;
    String pass = _conPassword.text;
    print('asd3');
    print(email);
    print(pass);
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Enter Email",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (email.isNotEmpty && EmailValidator.validate(email) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Enter a valid Email",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (pass.isEmpty || pass.length > 14) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Enter a Valid Password",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else {
      print("asd4");
      final res = await DatabaseHelper.getLoginUser(email, pass);
      final uname = res[0]['username'];
      final uid = res[0]['userid'];
      print(res);
      print("asd5");
      print(uid);
      if (res.isNotEmpty) {
        print('asdasd');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(username: uname, userid: uid)),
          //RecipeGeneratorScreen(userid: uid)),
          // GeneratedRecipe(userid: uid)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
          child: Stack(
            children: [
              // Background Container with Name and Image
              Container(
                width: size.width,
                height: size.height,

                color: Color.fromARGB(
                    255, 251, 149, 106), // Set the background color
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Oh, Look Who's Back! Logging In... Again!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: const Image(
                        image:
                            AssetImage("assets/images/login-screen2-image.png"),
                        height: 280,
                      ),
                    ),
                  ],
                ),
              ),
              // Front Container with Email and Password Details
              Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  width: size.width,
                  height: size.height * 0.5,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "LogIn",
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5),
                        LoginForm(size),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "\nOR",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Form LoginForm(Size size) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width - 75,
            child: Column(
              children: [
                TextFormField(
                  controller: _conEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: ("Email"),
                    labelStyle: TextStyle(color: Colors.black45),
                    hintText: "abc",
                    hintStyle: TextStyle(color: Colors.black26),
                    hoverColor: Colors.black,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _conPassword,
                  obscureText: passwordvisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordvisible = !passwordvisible;
                        });
                        print(passwordvisible);
                      },
                      icon: passwordvisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    labelText: ("Password"),
                    labelStyle: const TextStyle(color: Colors.black45),
                    hintText: "Password",
                    hoverColor: Colors.black,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       "Forget Password?",
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: Login,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          letterSpacing: 3.0,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            //RecipeGeneratorScreen(userid: uid)),
            // GeneratedRecipe(userid: uid)),
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
    );
  }
}
