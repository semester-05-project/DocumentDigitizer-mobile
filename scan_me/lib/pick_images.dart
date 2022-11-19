import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImagesPage extends StatefulWidget {

  @override
  State<PickImagesPage> createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImagesPage> {

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void initState () {
    selectImages();
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selected Images')),

      body: Center (
        child: Column (
          children: [
            Expanded(
                child: Padding (
                  padding: const EdgeInsets.all(3),
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                          crossAxisCount: 2
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(File(imageFileList![index].path),
                        fit: BoxFit.cover,
                        );
                      }
                  ),
                )
            )
          ],
        ),
      )
    );
  }
}

class PickFilesPage extends StatefulWidget {

  @override
  State<PickFilesPage> createState() => _PickFilesState();
}

class _PickFilesState extends State<PickFilesPage> {

  void initState () {
    selectFiles();
  }

  void selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        setState(() {

        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Selected Images')),

        body: Center (
          child: Column (
            children: [
              Expanded(
                  child: Padding (
                    padding: const EdgeInsets.all(3)
                  )
              )
            ],
          ),
        )
    );
  }
}