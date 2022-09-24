import 'package:scan_me/sign_in.dart';
import 'package:scan_me/sign_up.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recently Scanned Documents"),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search)),

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
                      Navigator.of(context).
                        pushReplacement( MaterialPageRoute(
                          builder: (BuildContext context) => const SignIn()));
                    } else if (value == 1) {
                      Navigator.of(context).
                        pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const SignUp()));
                    }
                   }
                  ),

        ],
      ),
      body:
      ListView(
        children: <Widget> [
          Card(
            child: ListTile(
              title:Text("Document One") ,
            )
          ),
          Card(
            child: ListTile(
              title: Text("Document Two"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Document Three"),
            )
          ),
          Card(
            child: ListTile(
              title:Text("Document Four") ,
            )
          ),
          Card(
            child: ListTile(
              title: Text("Document Five"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Document Six"),
            )
          ),
          Card(
            child: ListTile(
              title:Text("Document Seven") ,
            )
          ),
          Card(
            child: ListTile(
              title: Text("Document Eight"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Document Nine"),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              Icon(
                Icons.home,
                color: Color.fromARGB(255, 52, 12, 122),
                size: 30.0,
              ),

              Icon(
                Icons.add_a_photo_rounded,
                color: Color.fromARGB(255, 52, 12, 122),
                size: 30.0,
              ),

              Icon(
                Icons.photo_library,
                color: Color.fromARGB(255, 52, 12, 122),
                size: 30.0,
              ),

              Icon(
                Icons.account_circle_sharp,
                color: Color.fromARGB(255, 52, 12, 122),
                size: 30.0,
              ),
  ],
),
        ],
        shrinkWrap: true,

      ),
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

