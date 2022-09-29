import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan_me/home_page.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  @override
  // TODO: implement widget
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        leading:
        IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const HomePage())),
            icon:const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _getHeader(),
            SizedBox(height: 10,),
            _profileName("Sivakajan"),
            SizedBox(height: 14,),
            _heading("Personal Details")  ,
            SizedBox(height: 10),
            _detailsCard(),
            SizedBox(height: 15,),
            logoutButton(),


          ],
        ),
      ),
    );
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
        style: TextStyle(fontSize: 16),
      ),
    );
  }
  Widget _detailsCard(){
    return Padding(padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Sivakajan"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ) ,
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Sivakajan81@gmail.com"),
            )
          ],
        ),
      ),
    ) ;
  }
  Widget logoutButton(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout),
          Text("Sign out")
        ],
      ),) ;
  }
}