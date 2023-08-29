// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app/views/signInScreen.dart';

signUpUser(
    String userName,
    String userPhone,
    String userEmail,
    String userPassword
    )async{
  User? userid=FirebaseAuth.instance.currentUser;

  try{
    await FirebaseFirestore.instance.collection("users")
        .doc(userid!.uid).set({
      "username":userName,
      "userPhone":userPhone,
      "userEmail":userEmail,
      "createdAt":DateTime.now().toString(),
      "userId":userid.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(()=>loginScreen())
    });
  } on FirebaseAuthException catch(e){
    print("Error $e");
  }
}