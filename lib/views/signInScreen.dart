import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/forgotPassword.dart';
import 'package:note_app/views/signUpScreen.dart';

import 'homeScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Login Screen"),
        // actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Lottie.asset("assets/38435-register.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: loginEmailController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: loginPasswordController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var loginEmail =
                        loginEmailController.text.toString().trim();
                    var loginPassword =
                        loginPasswordController.text.toString().trim();
                    try {
                      final User? firebaseuser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginEmail, password: loginPassword))
                          .user;
                      if (firebaseuser != null) {
                        Get.to(() => homeSceen());
                      } else {
                        print("check Email and Password");
                      }
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                    }
                  },
                  child: Text("Login")),
              GestureDetector(
                onTap: () {
                  Get.to(() => forgotPasswordScreen());
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Forgot password"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => signupScreen());
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Don't have an account Signup"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
