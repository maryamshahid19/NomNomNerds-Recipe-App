import 'package:flutter/material.dart';
import 'package:nomnomnerds/constants/sizes_strings.dart';
import 'package:nomnomnerds/screens/search_screen.dart';

//import '../../../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    super.key,
    required this.size,
    required this.username,
    required this.userid,
  });

  final Size size;
  final String username;
  final int userid;

  @override
  Widget build(BuildContext context) {
    final _conSearch = TextEditingController();
    return Container(
      margin: EdgeInsets.only(
        bottom: nDefaultSize * 2.0,
      ),
      height: size.height * 0.25,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: nDefaultSize,
              right: nDefaultSize,
            ),
            height: size.height * 0.25 -
                25, //left some space in container for searchbox
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 251, 149, 106),
              //color: Color.fromARGB(255, 244, 166, 57),

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi, $username',
                  style: TextStyle(
                      color: Color.fromARGB(255, 237, 229, 229),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Spacer(),
                // IconButton.filled(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => ProfileScreen()),
                //     );
                //   },
                //   icon: Icon(Icons.person, color: Colors.white, size: 40.0),
                //   alignment: Alignment.bottomRight,
                // ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: nDefaultSize,
              ), //search bar outermargin from screen
              padding: EdgeInsets.symmetric(
                horizontal: nDefaultSize,
              ), //search bar innertext padding
              height: 54, //of searchbox
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color:
                          Color.fromARGB(255, 251, 149, 106).withOpacity(0.4)),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _conSearch,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search any recipe",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 251, 149, 106)
                              .withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color:
                          Color.fromARGB(255, 251, 149, 106).withOpacity(0.5),
                    ),
                    onPressed: () {
                      String searched = _conSearch.text;
                      //print(searched);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            searched: searched,
                            userid: userid,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
