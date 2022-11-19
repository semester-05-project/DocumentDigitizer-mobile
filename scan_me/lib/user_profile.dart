import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan_me/home_page_signed_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scan_me/landing_page.dart';
import 'package:scan_me/model/user.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  String id = "uid";
  Map? userDetails;


  fetchData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String uid = user!.uid;
    if (uid != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((ds) {
              userDetails = ds.data();
              id = uid;
            }).catchError((e) {
               print(e);
            });
  }

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        // backgroundColor: Colors.white,
        leading:
        IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const HomePageSigned())),
            icon:const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body:FutureBuilder(
        future: fetchData(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
                children: <Widget>[
                  _getHeader(),
                  SizedBox(height: 15,),
                  _profileName(userDetails!['username']),
                  SizedBox(height: 40,),
                  _heading("Personal Details")  ,
                  SizedBox(height: 20),
                  _detailsCard(),
                  SizedBox(height: 50),
                  logoutButton()
              ],
        );

        }else if(snapshot.hasError){
          return const Center(child: Text("Error Occured"));
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
          },
    ));

  }
  Widget _getHeader(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://w7.pngwing.com/pngs/831/88/png-transparent-user-profile-computer-icons-user-interface-mystique-miscellaneous-user-interface-design-smile-thumbnail.png")
                ),
              ),
            ),)
        ]
    );
  }

  // Stream<UserClass> readUsers() => FirebaseFirestore
  //     .instance
  //     .collection("users")
  //     .snapshots().
  //     .map((snapshot) => );
   Widget _profileName(String name){
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black,fontSize: 24, fontWeight: FontWeight.w800
          ),
        ),
      ),);
  }
  Widget _heading(String heading){
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Text(
        heading,
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
      ),
    );
  }
  Widget _detailsCard(){
    return Padding(padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            // ListTile(
            //   leading: Icon(Icons.contact_mail_rounded),
            //   title: Text(id),
            // ),
            // Divider(
            //   height: 20,
            //   color: Colors.black,
            //   thickness: 1.0,
            // ) ,
            ListTile(
              leading: Icon(Icons.person),
              title: Text(userDetails!['username']),
            ),
            Divider(
              height: 20,
              color: Colors.black,
              thickness: 1.0,
            ) ,
            ListTile(
              leading: Icon(Icons.email),
              title: Text(userDetails!['email']),
            )
          ],
        ),
      ),
    ) ;
  }
  Widget logoutButton(){
    return FilledButton(
      onPressed: () => {
        FirebaseAuth.instance.signOut(),
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const LandingPage()))
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout),
          Text("Sign out"),
        ],
      ),


    ) ;
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonBar(
              children:
                [
                  Icon(Icons.logout),
                  Text("Sign out"),
                ],
          )
        ],
      ),) ;
  }
}