import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:scan_me/user_profile.dart';
import 'camera_mode.dart';
import 'pick_images.dart';


class HomePageSigned extends StatefulWidget {
  const HomePageSigned({Key? key}) : super(key: key);

  @override
  HomePageSignedState createState() => HomePageSignedState();
}

class HomePageSignedState extends State<HomePageSigned> {
  Future<ListResult>? futureFiles;
  Map<int, double> downloadProgress ={};

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String uid = user!.uid;
    futureFiles = FirebaseStorage.instance.ref('/${uid}').listAll();
  }
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
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context,snapshot){
          if(snapshot.hasData){
            final files = snapshot.data!.items;
            return ListView.builder(
              itemBuilder: (context,index){
                final file = files[index];
                double? progress = downloadProgress[index];
                return
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/pdf_logo.jpg"), // no matter how big it is, it won't overflow
                    ),
                    focusColor: Colors.blue,
                    contentPadding: EdgeInsets.all(5.0),
                    title: Text(file.name),
                    subtitle: progress != null
                        ? LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.blue,
                    ):
                    null,
                    trailing:Row(
                      mainAxisSize:  MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.download,
                            color: Colors.black,
                          ),
                          onPressed: () => downloadFile(context,index,file),
                        ),
                        IconButton(
                          icon:const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed:  () => {
                            deleteFile(context,file)
                          },
                        )
                      ],
                    )
                );
              },
              itemCount: files.length,);

          }else if(snapshot.hasError){
            return const Center(child: Text("Error Occured"));
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
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

  Future deleteFile(context,Reference ref) async {
    try {
      await FirebaseStorage.instance.ref().child('/${ref.fullPath}').delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted ${ref.name}')),
      );
    } catch (e) {
      print(e);
    }

  }

  Future downloadFile(context,int index,Reference ref) async {
    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';

    await Dio().download(
        url,
        path,

        onReceiveProgress:(receive,total){
          double progress = receive/total;

          setState(() {
            downloadProgress[index] = progress;
          });
        }
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded ${ref.name}')),
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