import 'package:flutter/material.dart';
import 'package:nomnomnerds/screens/home_screen.dart';
import 'package:nomnomnerds/screenwidgets/profile/body.dart';
//import 'package:shop_app/enums.dart';

//import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.userid, required this.username})
      : super(key: key);
  final int userid;
  final String username;
  // static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(userid: userid, username: username),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
        centerTitle: true,
        title: Text(
          'UserProfile',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          textAlign: TextAlign.center,
        ),
      ),

      body: Body(userid: userid, username: username),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
