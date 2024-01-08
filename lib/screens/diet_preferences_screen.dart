import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomnomnerds/DatabaseHandler/Database_Helper.dart';
import 'package:nomnomnerds/models/ingredients_model.dart';
import 'package:nomnomnerds/models/recipes_model.dart';
import 'package:nomnomnerds/models/user_diet_preferences.dart';
import 'package:nomnomnerds/screens/login_screen.dart';

class DietPrefScreen extends StatefulWidget {
  const DietPrefScreen({
    super.key,
    required this.userid,
  });
  final int? userid;
  @override
  State<DietPrefScreen> createState() => _DietPrefScreen(
        userid: userid,
      );
}

class _DietPrefScreen extends State<DietPrefScreen> {
  _DietPrefScreen({
    required this.userid,
  });

  Future<void> _loadrecipes() async {
    List<List<dynamic>> _datarecipe = [];
    List<int> recipe_id = [];
    List<String> recipe_name = [];
    List<String> description = [];
    List<String> cuisine = [];
    List<String> diet = [];
    List<int> prep_time = [];
    List<int> cook_time = [];
    List<String> instructions = [];
    List<String> image_url = [];
    // var dbHelper2;

    // @override
    // void initState() {
    //   super.initState();
    //   dbHelper2 = DatabaseHelper();
    // }

    recipe_id.clear();
    recipe_name.clear();
    description.clear();
    cuisine.clear();
    diet.clear();
    prep_time.clear();
    cook_time.clear();
    instructions.clear();
    image_url.clear();
    final _rawData =
        await rootBundle.loadString("assets/csv_files/Recipes3.csv");
    counter = 0;
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _datarecipe = _listData;
    });
    for (int i = 1; i < _datarecipe.length; i++) {
      recipe_id.add(_datarecipe[i][0].toInt());
      recipe_name.add(_datarecipe[i][1].toString());
      description.add(_datarecipe[i][2].toString());
      cuisine.add(_datarecipe[i][3].toString());
      diet.add(_datarecipe[i][4].toString());
      prep_time.add(_datarecipe[i][5].toInt());
      cook_time.add(_datarecipe[i][6].toInt());
      instructions.add(_datarecipe[i][7].toString());
      image_url.add(_datarecipe[i][8].toString());
    }

    RecipeModel rm = RecipeModel(
      recipe_id: recipe_id,
      recipe_name: recipe_name,
      description: description,
      cuisine: cuisine,
      diet: diet,
      prep_time: prep_time,
      cook_time: cook_time,
      instructions: instructions,
      image_url: image_url,
    );
    await DatabaseHelper.saveRecipes(rm);
    //print("a2");
  }

  Future<void> _loadingredients() async {
    List<List<dynamic>> _dataingredients = [];
    List<int> ing_id = [];
    List<String> ing_name = [];
    // var dbHelper2;

    // @override
    // void initState() {
    //   super.initState();
    //   dbHelper2 = DatabaseHelper();
    // }

    ing_id.clear();
    ing_name.clear();
    _dataingredients.clear();

    final _rawData =
        await rootBundle.loadString("assets/csv_files/ingredients3.csv");
    counter = 0;

    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _dataingredients = _listData;
    });
    for (int i = 1; i < _dataingredients.length; i++) {
      ing_id.add(_dataingredients[i][0].toInt());
      ing_name.add(_dataingredients[i][1].toString());
    }

    Ingredients im = Ingredients(ing_id: ing_id, ing_name: ing_name);
    await DatabaseHelper.saveIngredients(im);
  }

  List<List<dynamic>> _data = [];
  String? choosenvalue;
  List<dynamic> diet = [];
  List<bool> isSelected = [];
  int counter = 0;
  int maxcounter = 2;
  final int? userid;
  List<int> choice = [];
  var dbHelper;
  void _loaddiet() async {
    final _rawData = await rootBundle.loadString("assets/csv_files/diet3.csv");
    counter = 0;
    choice.clear();
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    var len = _listData.length;
    print("In diet screen $len");
    setState(() {
      _data = _listData;
    });
    diet.clear();
    isSelected.clear();
    for (int i = 1; i < _data.length; i++) {
      diet.add(_data[i][1].toString());
      isSelected.add(false);
    }
    print(counter);
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    // Call your function here
    _loaddiet();
    _loadingredients();
    _loadrecipes();
  }

  Future<void> save(UserDietPreferences ud) async {
    print("asdx");
    await DatabaseHelper.saveDietPref(ud);
  }

  AlertDialog showalertbox() {
    print("Chec2");
    return AlertDialog(
      content: Text(
        "Please Select 2 Diets",
      ),
      contentTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:
              Text("Ok", style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
    );
  }

  AlertDialog showalertbox2() {
    List<String> d = [
      diet[choice[0]],
      diet[choice[1]],
    ];
    print(d);

    UserDietPreferences ud = UserDietPreferences(
      userid: userid,
      diet: d,
    );

    save(ud);
    return AlertDialog(
      content: Text(
        "Diet Preferences Added",
      ),
      contentTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogInScreen(),
              ),
            );
            // _loadrecipes();
            // _loadingredients();
            // _loadRecipeIngredients();
          },
          child: Text(
            "Continue",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
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
          print(diet);
          showDialog(
            context: context,
            builder: (context) {
              return showalertbox2();
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
            'Select any 2 Diets',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView.builder(
          itemCount: diet.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5, // Add elevation for a shadow effect
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 251, 149, 106),
                  child: Icon(
                    Icons.food_bank_outlined,
                    color: Colors.white,
                  ),
                ),
                title: Text(diet[index].toString()),
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
