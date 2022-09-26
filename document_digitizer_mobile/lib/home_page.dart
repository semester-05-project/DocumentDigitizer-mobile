import 'dart:io';
import 'sign_in.dart';
import 'sign_up.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  File? _image;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page - SCAN ME"),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search)),

              PopupMenuButton(
                   // add icon, by default "3 dot" icon
                   itemBuilder: (context){
                     return [
                            const PopupMenuItem<int>(
                                value: 0,
                                child: Text("Sign In"),
                            ),

                            const PopupMenuItem<int>(
                                value: 1,
                                child: Text("Sign Up"),
                            ),
                        ];
                   },
                   onSelected:(value){
                    if (value == 0) {
                      Navigator.of(context).
                        pushReplacement( MaterialPageRoute(
                          builder: (BuildContext context) => const SignIn()));
                    } else if (value == 1) {
                      Navigator.of(context).
                        pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const SignUp()));
                    }
                   }
                  ),
        ],
      ),

      body: Center(
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
        tooltip: "increment",
        child: const Icon(Icons.camera_alt),
        ),

    );
  }

  void getImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);

  }
}

class ImageSource {
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}

