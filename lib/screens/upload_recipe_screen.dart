import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomnomnerds/models/user_recipe_model.dart';
import '../DatabaseHandler/Database_Helper.dart';

class UploadRecipeScreen extends StatefulWidget {
  UploadRecipeScreen({
    super.key,
    required this.userid,
  });
  final int userid;
  @override
  State<UploadRecipeScreen> createState() =>
      _UploadRecipeScreenState(userid: userid);
}

class _UploadRecipeScreenState extends State<UploadRecipeScreen> {
  _UploadRecipeScreenState({
    required this.userid,
  });
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dietController = TextEditingController();
  TextEditingController _cuisineController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _ingredientController = TextEditingController();
  TextEditingController _prepTimeController = TextEditingController();
  TextEditingController _cookTimeController = TextEditingController();
  TextEditingController _instructionsController = TextEditingController();
  int? rid;
  final int userid;
  double _prepTimeSliderValue = 0;
  double _cookTimeSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 251, 149, 106),
        centerTitle: true,
        title: Text(
          'UploadRecipe',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 5,
              ),
              _buildTextField("Recipe Name", _nameController),
              SizedBox(height: 16),
              _buildTextField("Diet", _dietController),
              SizedBox(height: 16),
              _buildTextField("Cuisine", _cuisineController),
              SizedBox(height: 16),
              _buildTextField("Description", _descriptionController),
              SizedBox(height: 16),
              _buildTextField("Ingredients", _ingredientController),
              SizedBox(height: 16),
              _buildTextField("Instructions", _instructionsController),
              SizedBox(height: 16),
              _buildTimeField("Preperation Time", _prepTimeSliderValue),
              SizedBox(height: 16),
              _buildTimeField("Cooking Time", _cookTimeSliderValue),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  setState(() {
                    _submitForm();
                    _nameController.text = '';
                    _dietController.text = '';
                    _cuisineController.text = '';
                    _descriptionController.text = '';
                    _prepTimeController.text = '';
                    _cookTimeController.text = '';
                    _instructionsController.text = '';
                    _ingredientController.text = '';
                    _prepTimeSliderValue = 0;
                    _cookTimeSliderValue = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavBar(username: widget.username, userid: userid),
    );
  }

  // Helper method to create a text field
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Color.fromARGB(255, 210, 136, 109).withOpacity(0.8),
        //   ),
        // ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
          ),
        ),
      ),
      cursorColor: Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
    );
  }

  Widget _buildTimeField(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        Slider(
          activeColor: Color.fromARGB(255, 251, 149, 106).withOpacity(0.8),
          value: value,
          onChanged: (newValue) {
            setState(() {
              if (label == "Preperation Time") {
                _prepTimeSliderValue = newValue;
              } else if (label == "Cooking Time") {
                _cookTimeSliderValue = newValue;
              }
            });
          },
          min: 0,
          max: 180, // Adjust the max value as needed
          divisions: 120,
          label: value.round().toString() + " minutes",
        ),
      ],
    );
  }

  AlertDialog showalertbox(UserRecipeModel rm) {
    print("Check2");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      content: Container(
        height: height / 4,
        width: width,
        child: Column(
          children: [
            Text(
              "Recipe Uploaded",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset(
              'assets/images/tick.svg', // Replace with the actual path to your SVG file
              height: 55, // Adjust the height as needed
              width: 55, // Adjust the width as needed
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width,
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.saveUserRecipes(rm);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  primary: Colors.white, // Background color // Text color
                  padding:
                      EdgeInsets.symmetric(horizontal: 20), // Adjust padding
                ),
                child: Text(
                  "Ok",
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          Color.fromARGB(255, 251, 149, 106).withOpacity(0.8)),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 251, 149, 106),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  // Method to handle form submission
  Future<void> _submitForm() async {
    // Retrieve values from controllers
    String rname = _nameController.text;
    String rdiet = _dietController.text;
    String rcuisine = _cuisineController.text;
    String rdescription = _descriptionController.text;
    //String rprepTime = _prepTimeController.text;
    //int temprprepTime = int.tryParse(rprepTime) ?? 0;
    double temprprepTime = _prepTimeSliderValue;
    //String rcookTime = _cookTimeController.text;
    //int temprcookTime = int.tryParse(rcookTime) ?? 0;
    double temprcookTime = _cookTimeSliderValue;
    String rinstructions = _instructionsController.text;
    print("in submitform");
    if (rname.isEmpty ||
        rdiet.isEmpty ||
        rcuisine.isEmpty ||
        rdescription.isEmpty ||
        temprcookTime == 0 ||
        temprprepTime == 0 ||
        rinstructions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Fill All Fields",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else {
      var rm = UserRecipeModel(
        userid: userid,
        recipe_id: rid,
        recipe_name: rname,
        description: rdescription,
        cuisine: rcuisine,
        diet: rdiet,
        prep_time: temprprepTime.toInt(),
        cook_time: temprcookTime.toInt(),
        instructions: rinstructions,
      );
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return showalertbox(rm);
            });
      });
    }
  }
}
