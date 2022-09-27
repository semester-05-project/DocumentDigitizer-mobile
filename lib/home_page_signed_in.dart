import 'package:flutter/material.dart';

class HomePageSigned extends StatefulWidget {

  const HomePageSigned({Key? key}) : super(key: key);

  @override
  HomePageSignedState createState() => HomePageSignedState();
}

class HomePageSignedState extends State<HomePageSigned> {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search)),

          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.account_circle_sharp)),



        ],
      ),

      body:
      ListView(
        // ignore: sort_child_properties_last
        children: <Widget> [

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
                Icons.photo_library_rounded,
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

