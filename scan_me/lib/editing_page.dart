import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_mode.dart';
import 'home_page.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);


  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing Page"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.document_scanner_rounded)),

              PopupMenuButton(
                   // add icon, by default "3 dot" icon
                   // icon: Icon(Icons.book)
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

      body: 
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(padding: EdgeInsets.only(right: 15)),

          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () async {
            
            },
            tooltip: "increment",
            child: const Icon(Icons.backup_sharp),
          ),

          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () async {
            
            },
            tooltip: "increment",
            child: const Icon(Icons.share_rounded),
          ),

          FloatingActionButton(
            heroTag: 'button3',
            onPressed: () async {
            await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
            },
            tooltip: "increment",
            child: const Icon(Icons.add_box_rounded),
      ),

          FloatingActionButton(
            heroTag: 'button4',
            onPressed: () async {
            },
            tooltip: "increment",
            child: const Icon(Icons.picture_as_pdf_rounded),
      ),

          FloatingActionButton(
            heroTag: 'button5',
            onPressed: () async {
            },
            tooltip: "increment",
            child: const Icon(Icons.delete_rounded),
      ),
        ],
      ),

    );
  }
}