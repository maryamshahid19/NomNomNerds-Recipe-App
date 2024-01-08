import 'package:flutter/material.dart';
import 'package:nomnomnerds/screens/splash_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          //backgroundColor: Color.fromARGB(255, 239, 202, 150),
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 234, 180, 122),
            fontSize: 38,
            letterSpacing: 1.0,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 237, 204, 192),
            fontSize: 38,
            letterSpacing: 1.0,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(210, 248, 246, 246),
            fontSize: 23,
            letterSpacing: 1.0,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            // backgroundColor:                     255, 251, 149, 106), // Set the background color
            backgroundColor: Color.fromARGB(255, 251, 149, 106),
            foregroundColor: Color.fromARGB(255, 249, 246, 246),
            textStyle: TextStyle(
              letterSpacing: 3.0,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: Scaffold(
        body: SplashScreen(),
        //body: Test(),
      ),
    );
  }
}
