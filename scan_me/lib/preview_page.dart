import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'cropping_page.dart';
import 'editing_page.dart';

import 'filters_page.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),

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
            Text(picture.name),
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
                  .push(MaterialPageRoute(builder: (_) => const FiltersPage())),
                  child: const Icon(Icons.mode_edit_rounded),
                ),

                FloatingActionButton(
                  heroTag: 'button3',
                  tooltip: "increment",
                  onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const EditPage())),
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