import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Widget icon; // Change the type to Widget for accepting Icon widgets
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 251, 149, 106),
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: press,
        child: Row(
          children: [
            icon, // Use the provided icon directly
            SizedBox(width: 8),
            Expanded(
                child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
