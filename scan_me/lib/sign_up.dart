import 'package:scan_me/documents_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  
  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text ("Sign Up", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 15,),
                        Text("Create an Account, Its free!! ",style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),),
                        SizedBox(height: 20,)
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40
                      ),
                      child: Column(
                        children: [
                          makeInput(label: "Username"),
                          makeInput(label: "Email"),
                          makeInput(label: "Password",obsureText: true),
                          makeInput(label: "Confirm Pasword",obsureText: true)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40),
                      child: MaterialButton(
                      minWidth: double.infinity,
                      height:45,
                      color: Colors.deepPurple,
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(246, 246, 246, 1), ),
                      ),
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const HomePage())),
                        ),
                    ),
                    const SizedBox(height: 20,),
                                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Already have an account? "),
                        Text("SIGN IN",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                      ],
                    )
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label,obsureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      const SizedBox(height: 5,),
      TextField(
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
            ),
          ),
          border: OutlineInputBorder(
          ),
        ),
      ),
      const SizedBox(height: 30,)

    ],
  );
}