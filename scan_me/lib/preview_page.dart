import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'camera_mode.dart';
import 'cropping_page.dart';
import 'editing_page.dart';

import 'filters_page.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final File picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page'),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.white,
      leading:
      IconButton(
          onPressed: () {
            showAlertDialog(context);
          },
          icon:const Icon(
            Icons.close,
            size: 30,
            color: Colors.black,
          )
      ),
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
                  tooltip: "increment",
                  onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const CropPage())),
                  child: const Icon(Icons.crop_rounded),
                ),

                FloatingActionButton(
                  heroTag: 'button2',
                  tooltip: "increment",
                  onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FiltersPage())),
                  child: const Icon(Icons.mode_edit_rounded),
                ),

                FloatingActionButton(
                  heroTag: 'button3',
                  tooltip: "increment",
                  //onPressed: () => Navigator.of(context)
                  //.push(MaterialPageRoute(builder: (_) => const EditPage(picture: picture))),
                  onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditPage(
                    //picture: picture,
                  ))),
                  child: const Icon(Icons.check_rounded),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = ElevatedButton(
    child: Text("Discard"),
    onPressed: () async {
      await availableCameras().then((value) =>
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (_) => CameraPage(cameras: value))));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Are you sure to discard this image ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}