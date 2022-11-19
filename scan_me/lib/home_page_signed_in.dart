import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_me/crop_home_page.dart';
import 'package:scan_me/preview_scanned_pdf.dart';
import 'package:scan_me/user_profile.dart';
import 'camera_mode.dart';
import 'pick_images.dart';


class HomePageSigned extends StatefulWidget {

  const HomePageSigned({Key? key}) : super(key: key);

  @override
  HomePageSignedState createState() => HomePageSignedState();
}

class HomePageSignedState extends State<HomePageSigned> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () =>
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search)),

          IconButton(
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Profile())),
              icon: const Icon(Icons.account_circle_sharp)),
        ],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () async {
              await availableCameras().then((value) =>
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => CameraPage(cameras: value))));
            },
            tooltip: "increment",
            child: const Icon(Icons.camera_alt_rounded),
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 15)),


          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () =>
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PickImagesPage())),
            tooltip: "increment",
            child: const Icon(Icons.photo_library_rounded),
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 15)),


          FloatingActionButton(
            heroTag: 'button3',
            onPressed: () =>
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PickImagesPage())),
            tooltip: "increment",
            child: const Icon(Icons.file_copy_rounded),
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 15)),

        ],
      ),

    );
  }
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