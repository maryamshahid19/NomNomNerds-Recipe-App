import 'package:flutter/material.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';

//import '../../../constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    super.key,
    required this.title,
    required this.press,
  });
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: nDefaultSize),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
          SizedBox(
            height: 30,
            width: 80,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 210, 136, 109).withOpacity(0.8),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    letterSpacing: 0.0,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: press(),
              child: Text(
                "More",
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 229, 229),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: nDefaultSize / 4),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(173, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}
