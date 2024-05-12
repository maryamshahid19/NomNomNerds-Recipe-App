import 'package:flutter/material.dart';
import 'dart:io';
import 'package:nomnomnerds/constants/image_strings.dart';
import 'package:nomnomnerds/constants/text_strings.dart';
import 'package:nomnomnerds/screens/login_screen.dart';
import 'package:nomnomnerds/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              content: Text('Do you want to exit the app?',
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text('Yes',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
              backgroundColor: Color.fromARGB(255, 251, 149, 106),
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(nWelcomeScreenImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Stack(
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.exit_to_app),
            // ),
            Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.2,
                  size.width * 0.1, size.height * 0.2),
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Text(
                    nWelcomeTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    selectionColor: Color.fromARGB(255, 251, 149, 106),
                  ),
                  SizedBox(height: 10),
                  Text(
                    nWelcomeSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height - size.height * 0.78),
                  Container(
                    height: size.height * 0.055,
                    width: size.width,
                    child: Expanded(
                      child: ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              // foregroundColor: MaterialStatePropertyAll(
                              //   Color.fromARGB(255, 249, 246, 246),
                              // ),
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogInScreen(),
                            ),
                          );
                        },
                        child: Text(
                          nLogin.toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 3.0,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * 0.055,
                    width: size.width,
                    child: Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 249, 246, 246),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 251, 149, 106),
                            //Color.fromARGB(255, 244, 166, 57),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          nSignup.toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 3.0,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
