import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/signInScreen.dart';

import '../services/signupServices.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({Key? key}) : super(key: key);

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  TextEditingController userNameController=TextEditingController();
  TextEditingController userPhoneController=TextEditingController();
  TextEditingController userEmailController=TextEditingController();
  TextEditingController userPasswordController=TextEditingController();

  User ? currentUser=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Signup Screen"),
        actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250,
                child: Lottie.asset("assets/38435-register.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person),
                      hintText: "Username", enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userPhoneController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      hintText: "Phone", enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintText: "Email", enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userPasswordController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () async{
                var userName=userNameController.text.toString().trim();
                var userPhone=userPhoneController.text.toString().trim();
                var userEmail=userEmailController.text.toString().trim();
                var userPassword=userPasswordController.text.toString().trim();

                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: userEmail,
                    password: userPassword
                ).then((value) => {
                  log("user created"),
                  signUpUser(
                      userName,
                      userPhone,
                      userEmail,
                      userPassword,
                  ),
                  //
                  FirebaseFirestore.instance.collection("users")
                      .doc(currentUser!.uid.toString()).set({
                    "password" : userPassword,
                    "username":userName,
                    "userPhone":userPhone,
                    "userEmail":userEmail,
                    "createdAt":DateTime.now().toString(),
                    "userId":currentUser!.uid.toString(),

                  }),
                  log("user edit"),
                });

              }, child: Text("Signup")),
              SizedBox(
                height: 0,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=> loginScreen());
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Already have an account Signin"),
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
