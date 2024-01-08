import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: SizedBox(
        height: 130,
        width: 130,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
            // Positioned(
            //   right: -16,
            //   bottom: 0,
            //   child: SizedBox(
            //     height: 46,
            //     width: 46,
            //     // child: TextButton(
            //     //   style: TextButton.styleFrom(
            //     //     shape: RoundedRectangleBorder(
            //     //       borderRadius: BorderRadius.circular(50),
            //     //       side: BorderSide(color: Colors.white),
            //     //     ),
            //     //     // primary: Colors.white,
            //     //     backgroundColor: const Color.fromARGB(255, 216, 213, 213),
            //     //   ),
            //     //   onPressed: () {},
            //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
