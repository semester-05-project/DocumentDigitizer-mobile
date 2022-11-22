import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/photofilters.dart';

class FiltersPage extends StatefulWidget {

  @override
  State<FiltersPage> createState() => FiltersPageState();
}

class FiltersPageState extends State<FiltersPage> {

  List<Filter> filters = presetFiltersList;
  File? imageFile;
  late String fileName;

  get image => null;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Photo Filter Example'),
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Center(
            child: new Text('No image selected.'),
          )
              : Image.file(imageFile!),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(ImageSource.gallery),
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(
        source: source,
        imageQuality: 100
    );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }

    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Photo Filter Example"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      print(imageFile?.path);
    }
  }

}