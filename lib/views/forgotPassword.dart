import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/signInScreen.dart';

class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {
  TextEditingController forgetPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("forgot password"),
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
                  controller: forgetPasswordController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintText: "Email", enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () async {
                var forgotEmail=forgetPasswordController.text.toString().trim();
                try{
                await  FirebaseAuth.instance.sendPasswordResetEmail(
                      email:forgotEmail).
                then((value) {
                  print("Email sent");
                  Get.off(()=> loginScreen());
                  });
                }on FirebaseAuthException catch (e){
                  print("Error $e");
                }
              }, child: Text("Forgot password")),

            ],
          ),
        ),
      ),
    );
  }
}
