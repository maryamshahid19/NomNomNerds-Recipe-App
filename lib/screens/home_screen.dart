import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nomnomnerds/screenwidgets/homescreen/body.dart';
import 'package:nomnomnerds/appwidgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    required this.username,
    required this.userid,
  });

  final String username;
  final int userid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Exit App',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              content: Text(
                'Are you sure you want to Quit?',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {
                    exit(0);
                  },
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
              backgroundColor: Color.fromARGB(255, 255, 251, 250),
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: Body(username: widget.username, userid: widget.userid),
        bottomNavigationBar:
            BottomNavBar(username: widget.username, userid: widget.userid),
      ),
    );
  }
}
