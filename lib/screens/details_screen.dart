import 'package:flutter/material.dart';
import 'package:nomnomnerds/screenwidgets/detailscreen/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.uid,
    required this.id,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.diet,
    required this.preptime,
    required this.cooktime,
    required this.instructions,
    required this.image,
  });

  final String name, description, cuisine, diet, instructions, image;
  final int uid, id, preptime, cooktime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Text('Hello'),
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: Navigator.of(context).pop,
      //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
      //   ),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Body(
        userid: uid,
        id: id,
        image: image,
        name: name,
        cuisine: cuisine,
        description: description,
        diet: diet,
        preptime: preptime,
        cooktime: cooktime,
        instructions: instructions,
      ),
    );
  }
}
