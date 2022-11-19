import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scan_me/crop_app_helper.dart';
import 'dart:io';
import 'editing_page.dart';

import 'filters_page.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);
  final  File picture;
  @override
  State<PreviewPage> createState() => _PreviewPageState( );
}

class _PreviewPageState extends State<PreviewPage> {
  File? picture1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() => picture1 = widget.picture);
  }

  Future CropImage() async {
    // final _pickedImage = await _picker.pickImage(source: source);
    File picture = widget.picture;
    if (picture != null) {
      var image = File(picture.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      var _compressedImage = await CropAppHelper.compress(image: image);
      final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      print('After Compress $_sizeInKbAfter kb');
      var _croppedImage = await CropAppHelper.cropImage(_compressedImage);
      print('cropped Image');
      if (_croppedImage == null) {
        return;
      }
      // picture = File(_croppedImage!.path);
      print(picture1);
      print(_croppedImage);
      setState(() => picture1 = _croppedImage);
      print("picture");
      print(picture1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),

      body: Center(
        child: Column(

            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(
                  File(picture1!.path),
                  fit: BoxFit.cover,
                  width: 250
              ),
              const SizedBox(height: 24),
              Text(widget.picture.path.split('/').last),
                  const Padding(
                  padding: EdgeInsets.only(top: 25)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  FloatingActionButton(
                    heroTag: 'button1',
                    tooltip: "increment",
                    onPressed: () {
                      CropImage();
                    },
                    child: const Icon(Icons.crop_rounded),
                  ),


                  FloatingActionButton(
                    heroTag: 'button2',
                    tooltip: "increment",
                    onPressed: () =>
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (_) => const FiltersPage())),
                    child: const Icon(Icons.mode_edit_rounded),
                  ),

                  FloatingActionButton(
                    heroTag: 'button3',
                    tooltip: "increment",
                    //onPressed: () => Navigator.of(context)
                    //.push(MaterialPageRoute(builder: (_) => const EditPage(picture: picture))),
                    onPressed: () =>
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditPage(
                                      picture: picture1!,
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


//
//
// class PreviewPage extends StatelessWidget {
//   const PreviewPage({Key? key, required this.picture}) : super(key: key);
//   final XFile picture = picture;
//
//
//   _getImageFrom() async {
//     // final _pickedImage = await _picker.pickImage(source: source);
//     if (picture != null) {
//       var image = File(picture.path.toString());
//       final _sizeInKbBefore = image.lengthSync() / 1024;
//       print('Before Compress $_sizeInKbBefore kb');
//       var _compressedImage = await CropAppHelper.compress(image: image);
//       final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
//       print('After Compress $_sizeInKbAfter kb');
//       var _croppedImage = await CropAppHelper.cropImage(_compressedImage);
//       if (_croppedImage == null) {
//         return;
//       }
//       return _croppedImage;
//       // setState(() {
//       //   fileImage = _croppedImage;
//       // });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Preview Page')),
//
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.file(
//               File(picture.path),
//               fit: BoxFit.cover,
//               width: 250
//             ),
//             const SizedBox(height: 24),
//             Text(picture.name),
//             const Padding(
//                   padding: EdgeInsets.only(top: 25)
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children:  <Widget>[
//
//                 FloatingActionButton(
//                   heroTag: 'button1',
//                   tooltip: "increment",
//                   onPressed: _getImageFrom(),
//                   // onPressed: () => Navigator.push(context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => CropPage(
//                   //           picture: picture,
//                   //         ))),
//                   child: const Icon(Icons.crop_rounded),
//                 ),
//
//                 FloatingActionButton(
//                   heroTag: 'button2',
//                   tooltip: "increment",
//                   onPressed: () => Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (_) => const FiltersPage())),
//                   child: const Icon(Icons.mode_edit_rounded),
//                 ),
//
//                 FloatingActionButton(
//                   heroTag: 'button3',
//                   tooltip: "increment",
//                   //onPressed: () => Navigator.of(context)
//                   //.push(MaterialPageRoute(builder: (_) => const EditPage(picture: picture))),
//                   onPressed: () => Navigator.push(context,
//                       MaterialPageRoute(
//                           builder: (context) => EditPage(
//                             picture: picture,
//                           ))),
//                           child: const Icon(Icons.check_rounded),
//                 ),
//               ],
//             ),
//           ]
//         ),
//       ),
//     );
//   }
// }