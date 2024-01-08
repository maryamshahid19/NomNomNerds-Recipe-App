import 'package:flutter/material.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      height: 30,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: nDefaultSize),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 251, 149, 106),
          ),
        ),
      ),
      //    ],
      //  ),
    );
  }
}
