import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homeScreen.dart';

class editNoteScreen extends StatefulWidget {
  const editNoteScreen({Key? key}) : super(key: key);

  @override
  State<editNoteScreen> createState() => _editNoteScreenState();
}

class _editNoteScreenState extends State<editNoteScreen> {
  TextEditingController noteController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: noteController
                ..text="${Get.arguments["note"].toString()}",
            ),
            ElevatedButton(onPressed: () async{
              FirebaseFirestore.instance
                  .collection("notes")
                  .doc(Get.arguments["docId"].toString())
                  .update({
                "note":noteController.text.toString().trim(),
              }).then((value) {
                Get.offAll(()=>homeSceen());
                print("Data updated");
              });
            },
                child: Text("Edit"))
          ],
        ),
      ),
    );
  }
}
