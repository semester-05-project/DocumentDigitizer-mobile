import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_manager/file_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PreviewScannedPDF extends StatefulWidget {
  const PreviewScannedPDF({Key? key}) : super(key: key);
  @override
  State<PreviewScannedPDF> createState() => _PreviewScannedPDFState();
}

class _PreviewScannedPDFState extends State<PreviewScannedPDF> {
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
        title: Text("PDF List:"),

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
                return ListTile(
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
      )
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
    setState(() {
      futureFiles = futureFiles;
    });
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
