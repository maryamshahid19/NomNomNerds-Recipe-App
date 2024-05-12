import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:nomnomnerds/screens/splash_screen.dart';
//import 'dart:io';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          //backgroundColor: Color.fromARGB(255, 239, 202, 150),
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 251, 149, 106),
            fontSize: 38,
            letterSpacing: 1.0,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 237, 204, 192),
            fontSize: 38,
            letterSpacing: 1.0,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(210, 248, 246, 246),
            fontSize: 23,
            letterSpacing: 1.0,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            // backgroundColor:                     255, 251, 149, 106), // Set the background color
            backgroundColor: Color.fromARGB(255, 251, 149, 106),
            foregroundColor: Color.fromARGB(255, 249, 246, 246),
            textStyle: TextStyle(
              letterSpacing: 3.0,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: Scaffold(
        // body: Center(
        //   child: Column(
        //     children: [
        //       MaterialButton(
        //           color: Colors.amber,
        //           child: const Text(
        //             'Pick image from gallery',
        //           ),
        //           onPressed: () {
        //             _pickImageFromGallery();
        //           }),
        //       const SizedBox(height: 20),
        //       _selectedImage != null
        //           ? Image.file(_selectedImage)
        //           : Text('Please select an image'),
        //     ],
        //   ),
        // ),
        body: SplashScreen(),
        //body: Test(),
      ),
    );
  }

  // Future _pickImageFromGallery() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (returnedImage == null) return;

  //   setState(() {
  //     _selectedImage = File(returnedImage!.path);
  //   });
  // }
}


// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() {
//   runApp(App());
// }

// class App extends StatefulWidget {
//   App({Key? key}) : super(key: key);

//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   File? _selectedImage;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         colorScheme: ColorScheme.fromSwatch(
//           backgroundColor: Color.fromARGB(255, 245, 245, 245),
//         ),
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 234, 180, 122),
//             fontSize: 38,
//             letterSpacing: 1.0,
//           ),
//           headline2: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 237, 204, 192),
//             fontSize: 38,
//             letterSpacing: 1.0,
//           ),
//           bodyText1: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(210, 248, 246, 246),
//             fontSize: 23,
//             letterSpacing: 1.0,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             shape: const RoundedRectangleBorder(),
//             backgroundColor: Color.fromARGB(255, 251, 149, 106),
//             foregroundColor: Color.fromARGB(255, 249, 246, 246),
//             textStyle: TextStyle(
//               letterSpacing: 3.0,
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//               const SizedBox(height: 100),
//               MaterialButton(
//                   color: Colors.amber,
//                   child: const Text(
//                     'Pick image from gallery',
//                   ),
//                   onPressed: () {
//                     _pickImageFromGallery();
//                   }),
//               const SizedBox(height: 20),
//               _selectedImage != null
//                   ? Image.file(_selectedImage!)
//                   : Text('Please select an image'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImageFromGallery() async {
//     final returnedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (returnedImage == null) return;

//     setState(() {
//       _selectedImage = File(returnedImage.path);
//     });
//   }
// }
