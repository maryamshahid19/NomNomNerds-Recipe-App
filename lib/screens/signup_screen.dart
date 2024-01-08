import 'package:flutter/material.dart';
import 'package:nomnomnerds/models/users_model.dart';
import 'package:nomnomnerds/screens/login_screen.dart';
import 'package:nomnomnerds/screens/categories_screen.dart';
import '../DatabaseHandler/Database_Helper.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _conUsername = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void dispose() {
    _conUsername.dispose();
    _conEmail.dispose();
    _conPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  signUp() async {
    int? uid;
    String uname = _conUsername.text;
    String email = _conEmail.text;
    String pass = _conPassword.text;
    var check = await DatabaseHelper.getLoginUser(email, pass);
    if (uname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Enter Username",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (email.isEmpty) {
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
    } else if (check.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Account Already Exists",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else {
      UserModel um = UserModel(
        userid: uid,
        username: uname,
        email: email,
        password: pass,
      );
      print("a2");
      int userid = await DatabaseHelper.saveData(um);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Account Created",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoriesScreen(userid: userid)),
      );
    }
    // if (pass.length > 14) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text(
    //         "Please Enter Password",
    //         style: TextStyle(fontSize: 14),
    //       ),
    //     ),
    //   );
    // } else {
    //   saveData();
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          // Background with NomNomNerds text
          Column(
            children: [
              Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.1,
                  size.height * 0.05,
                  size.width * 0.1,
                  size.height * 0.05,
                ),
                color: Color.fromARGB(
                    255, 251, 149, 106), // Set the background color

                child: Column(
                  children: [
                    Text(
                      'NomNomNerds',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Image(
                        image:
                            AssetImage("assets/images/splash-screen-image.png"),
                        width: 185,
                      ),
                    ),
                  ],
                ),
                // ),
              ),
            ],
          ),
          // Foreground with Sign Up form
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
              height: size.height * 0.55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text(
                      "SignUp",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: SignUpForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form SignUpForm(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _conUsername,
            validator: (value) {
              if (value!.isNotEmpty) {
                return null;
              } else {
                return "Enter Username!";
              }
            },
            decoration: InputDecoration(
              label: Text(
                "Username",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 15, color: Colors.black45),
              ),
              prefixIcon: const Icon(
                Icons.person_outline_rounded,
              ),
              enabledBorder: const OutlineInputBorder(
                //  borderRadius: BorderRadius.all(20),
                borderSide: BorderSide(color: Colors.black45, width: 2.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 251, 149, 106),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _conEmail,
            validator: (value) {
              if (value!.isNotEmpty) {
                return null;
              } else {
                return "Enter Email!";
              }
            },
            decoration: InputDecoration(
              label: Text(
                "Email",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 15, color: Colors.black45),
              ),
              prefixIcon: const Icon(
                Icons.email_outlined,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black45,
                  width: 2.5,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 251, 149, 106),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _conPassword,
            validator: (value) {
              if (value!.isNotEmpty) {
                return null;
              } else {
                return "Enter Password!";
              }
            },
            decoration: InputDecoration(
              label: Text(
                "Password",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
              ),
              prefixIcon: const Icon(Icons.password),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black45,
                  width: 2.5,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 251, 149, 106),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: signUp,
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
              child: const Text("SIGNUP"),
            ),
          ),
          const SizedBox(
            height: 0.5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogInScreen(),
                  ),
                );
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already Have an Account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15),
                    ),
                    TextSpan(
                      text: " Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
      //  title: TextButton(
      //     child: Text("Delete Table"),
      //     onPressed: () {
      //       DatabaseHelper.dropTable();
      //     },
      //   ),
    );
  }
}
