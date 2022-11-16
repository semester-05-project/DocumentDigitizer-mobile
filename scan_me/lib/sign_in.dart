import 'package:firebase_auth/firebase_auth.dart';
import 'package:scan_me/landing_page.dart';

import 'home_page_signed_in.dart';
import 'sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future SignIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
  //
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MainPage()));
  //
  //   // print(_emailController.text);
  // }
  Future<String?> SignIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password:  _passwordController.text.trim(),
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                .push(MaterialPageRoute(builder: (_) => const MainPage())),
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
                        Text ("Sign In", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                        SizedBox(height: 15,),
                        Text("Welcome Back!! Sign In with your credentials ",style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),),
                        SizedBox(height: 20,),
                        Padding(padding: EdgeInsets.only(bottom: 30))
                      ],
                    ),
                    Padding(
                      padding: const
                      EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        children: [
                          makeInput(key:"signin_email",label: "Email",controller: _emailController),
                          makeInput(key:"signin_password",label: "Password",obsureText: true,controller: _passwordController),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40),
                      child: MaterialButton(

                        minWidth: double.infinity,
                        height:45,
                        color: const Color.fromARGB(255, 52, 12, 122),
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white, ),
                        ),
                        key: Key("signin_submit"),
                        // onPressed: () => Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (_) => const HomePageSigned())),


                        onPressed: () async {
                          final message = await SignIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (message!.contains('Success')) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        },





                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        const Text("Does not have an account? "),

                        MaterialButton(
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),
                          ),
                          onPressed: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => const SignUp())),
                        ),
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

// class SignIn extends StatelessWidget {
//   const SignIn({super.key});
//
//   @override
//
// }

Widget makeInput({key,label,controller,obsureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black
      ),),
      const SizedBox(height: 5,),
      TextField(
        key: Key(key),
        controller: controller,
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