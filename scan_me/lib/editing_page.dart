import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_mode.dart';
import 'home_page.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class EditPage extends StatelessWidget {

  const EditPage({Key? key, required this.picture}) : super(key: key);

  final File picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing Page"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.document_scanner_rounded)
          ),

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
                Navigator.of(context).pushReplacement( MaterialPageRoute(
                    builder: (BuildContext context) => const SignIn()
                  )
                );
              } else if (value == 1) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const SignUp()));
              }
            }
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Image.file(
              File(picture.path), 
              fit: BoxFit.cover, 
              width: 250
            ),

            const SizedBox(height: 24),

            //Text(picture.name),

            const Padding(
                  padding: EdgeInsets.only(top: 25)
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  <Widget>[
                FloatingActionButton(
                  heroTag: 'button1',
                  onPressed: () async {},
                  tooltip: "increment",
                  child: const Icon(Icons.backup_sharp),
                ),

                FloatingActionButton(
                  heroTag: 'button2',
                  onPressed: () async {},
                  tooltip: "increment",
                  child: const Icon(Icons.share_rounded),
                ),

                FloatingActionButton(
                  heroTag: 'button3',
                  onPressed: () async {
                    await availableCameras().then(
                      (value) => Navigator.push(
                        context, MaterialPageRoute(
                          builder: (_) => CameraPage(cameras: value)
                        )
                      )
                    );
                  },
                  tooltip: "increment",
                  child: const Icon(Icons.add_box_rounded),
                ),

                FloatingActionButton(
                  heroTag: 'button4',
                  onPressed: () async {},
                  tooltip: "increment",
                  child: const Icon(Icons.picture_as_pdf_rounded),
                ),

                FloatingActionButton(
                  heroTag: 'button5',
                  onPressed: () async {},
                  tooltip: "increment",
                  child: const Icon(Icons.delete_rounded),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}