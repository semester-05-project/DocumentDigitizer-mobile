import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scan_me/crop_app_helper.dart';
import 'camera_mode.dart';

class CropPage extends StatefulWidget {
  const CropPage({Key? key}) : super(key: key);

  // final XFile picture;

  @override
  State<CropPage> createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {

  _cropImage({required XFile imageSource}) async {
    if (imageSource != null) {
      var image = File(imageSource.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      var _compressedImage = await CropAppHelper.compress(image: image);
      final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      print('After Compress $_sizeInKbAfter kb');
      var _croppedImage = await CropAppHelper.cropImage(_compressedImage);
      if (_croppedImage == null) {
        return;
      }
    //   setState(() {
    //     picture = _croppedImage;
    //   });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


// class CropPage extends StatelessWidget {
//   const CropPage({Key? key,required this.picture}) : super(key: key);
//
//   final XFile picture;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }




// class CropPage extends StatefulWidget {
//   const CropPage({Key? key,required this.picture}) : super(key: key);
//
//   File? picture;
//
//   @override
//   State<CropPage> createState() => _CropPageState();
// }
//
// class _CropPageState extends State<CropPage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }