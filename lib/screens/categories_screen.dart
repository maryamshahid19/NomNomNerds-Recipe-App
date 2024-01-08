import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/models/user_categories.dart';
import 'package:nomnomnerds/screens/diet_preferences_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.userid,
  });
  final int? userid;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreen(userid: userid);
}

class _CategoriesScreen extends State<CategoriesScreen> {
  _CategoriesScreen({
    required this.userid,
  });
  List<List<dynamic>> _data = [];
  String? choosenvalue;
  List<dynamic> categories = [];
  List<bool> isSelected = [];
  int counter = 0;
  int maxcounter = 5;
  final int? userid;
  List<int> choice = [];
  var dbHelper;
  void _loadcategories() async {
    final _rawData = await rootBundle.loadString("assets/csv_files/Book3.csv");
    counter = 0;
    choice.clear();
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    var len = _listData.length;
    print("in cat screen $len");
    setState(() {
      _data = _listData;
      //   print(_data[0][0].toString());
    });
    categories.clear();
    isSelected.clear();
    for (int i = 1; i < _data.length; i++) {
      categories.add(_data[i][0].toString());
      isSelected.add(false);
      //print("$categories[i] and $isSelected[i]\n");
    }
    //   print(categories.length);
    // print("Check2");
    // print("Check3");
    //print(counter);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Call your function here
    _loadcategories();
  }

  Future<void> save(UserCategories uc) async {
    print("asdx");
    await DatabaseHelper.saveCategory(uc);
  }

  AlertDialog showalertbox() {
    print("Chec2");
    return AlertDialog(
      content: Text(
        "Please Select 5 Categories",
      ),
      contentTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 251, 149, 106),
            ), // Set the background color to pink
          ),
          child:
              Text("Ok", style: TextStyle(color: Colors.black, fontSize: 25)),
        ),
      ],
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
    );
  }

  AlertDialog showalertbox2(int ucid) {
    print("Chec23");
    return AlertDialog(
      content: Text(
        "Categories Added",
      ),
      contentTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DietPrefScreen(
                  userid: ucid,
                ),
              ),
            );
          },
          child: Text("Continue",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
    );
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(userid);
    var add = FloatingActionButton(
      onPressed: () {
        if (counter < maxcounter) {
          print("Check");
          //show = true;
          showDialog(
            context: context,
            builder: (context) {
              return showalertbox();
            },
          );
        } else {
          List<String> cats = [
            categories[choice[0]],
            categories[choice[1]],
            categories[choice[2]],
            categories[choice[3]],
            categories[choice[4]],
          ];
          print(cats);

          UserCategories uc = UserCategories(
            userid: userid,
            categories: cats,
          );
          int? abc = uc.userid;
          print("ucid:$abc");
          save(uc);
          showDialog(
            context: context,
            builder: (context) {
              return showalertbox2(abc!);
            },
          );
        }
      },
      child: Text("Ok"),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return showalertbox();
                },
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 251, 149, 106),
          title: Text(
            'Select any 5 Cuisine',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.15,
                child: ListTile(
                  leading: Container(
                    width: 50, // Adjust the width to set the square shape
                    height: 50, // Adjust the height to set the square shape
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 251, 149, 106),
                      child: Icon(
                        Icons.food_bank_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(categories[index].toString()),
                  trailing: isSelected[index]
                      ? Icon(
                          Icons.check_circle,
                          color: Color.fromARGB(255, 251, 149, 106),
                        )
                      : Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.grey,
                        ),
                  onTap: () {
                    print(counter);
                    print(isSelected[index]);
                    if (counter < maxcounter && isSelected[index] == false) {
                      setState(() {
                        isSelected[index] = true;
                        counter++;
                        print(counter);
                        choice.add(index);
                        print(choice);
                      });
                    }
                  },
                  onLongPress: () {
                    print(counter);
                    print(isSelected[index]);
                    if (counter > 0 && isSelected[index] == true) {
                      setState(() {
                        isSelected[index] = false;
                        counter--;
                        choice.remove(index);
                      });
                    }
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Spacer(),
            add,
          ],
        ),
      ),
    );
  }
}
