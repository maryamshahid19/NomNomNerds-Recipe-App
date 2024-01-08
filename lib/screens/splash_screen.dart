// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nomnomnerds/screens/welcome_screen.dart';
import 'package:nomnomnerds/constants/image_strings.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/constants/text_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    // var refresh = FloatingActionButton(
    //   child: const Icon(Icons.refresh_outlined),
    //   onPressed: _loadrecipes,
    // );
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 251, 149, 106),
        //color: Color.fromARGB(255, 232, 169, 80),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 3000),
                opacity: animate ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.all(nDefaultSize),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Image(
                      image: AssetImage(nSplashLogoImage),
                      width: nSplashLogoSize,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 3000),
                opacity: animate ? 1 : 0,
                child: Text(
                  nAppName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Row(
      //   children: [
      //     SizedBox(
      //       width: 30,
      //     ),
      //     refresh,
      //     Spacer(),
      //   ],
      // ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => animate = true);

    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }
}
