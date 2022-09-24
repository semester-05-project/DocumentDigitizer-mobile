import 'dart:async';
import 'package:scan_me/documents_view.dart';
import "package:flutter/material.dart";
 
void main() {
  runApp(myapp());
}
// stateful visit

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan Me App Started',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), 
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()))
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 52, 12, 122)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "SCAN ME",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 85.0,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                      ),

                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: Icon(
                          Icons.file_copy_rounded,
                          color: Color.fromARGB(255, 52, 12, 122),
                          size: 70.0,
                        )
                      ),
                    ],
                    ),
                ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        ),
                      Text(
                        "Best Online Scanning App \n for Everyone...",
                        style: TextStyle (
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,

                        ),

                      ),
                    ],
                    ),
                  ),

          ],)
        ],
        )
    );
  }
}
