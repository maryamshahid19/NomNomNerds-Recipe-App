import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:nomnomnerds/screenwidgets/detailscreen/body.dart';
import 'package:nomnomnerds/screenwidgets/userdetailscreen/user_rec_details.dart';

class UserRecipeBody extends StatelessWidget {
  const UserRecipeBody({
    super.key,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.instructions,
  });

  final String name, description, cuisine, diet, instructions;
  final int preptime, cooktime;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: Navigator.of(context).pop,
      //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
      //   ),
      //   title: Text(
      //     "Details",
      //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      //   ),
      //   backgroundColor: Colors.transparent
      // ),
      body: Container(
        //height: size.height,
        //width: size.width,
        constraints: BoxConstraints.expand(),

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chef.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: size.width * 0.12,
              left: size.width * 0.08,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.07,
              right: (size.width - size.width * 0.8) / 2,
              child: SizedBox(
                height: size.height * 0.55,
                width: size.width * 0.8,
                child: ClipRect(
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color.fromARGB(255, 191, 188, 188)
                              .withOpacity(0.4)),
                      child: UserRecDetails(
                        name: name,
                        cuisine: cuisine,
                        description: description,
                        diet: diet,
                        instructions: instructions,
                        preptime: preptime,
                        cooktime: cooktime,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
