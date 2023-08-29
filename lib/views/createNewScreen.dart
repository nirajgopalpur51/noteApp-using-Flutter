import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/views/homeScreen.dart';

class createNotesScreen extends StatefulWidget {
  const createNotesScreen({Key? key}) : super(key: key);

  @override
  State<createNotesScreen> createState() => _createNotesScreenState();
}

class _createNotesScreenState extends State<createNotesScreen> {
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;   //Id of current user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Add Note"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.toString().trim();
                  if (note != " ") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes") // for collection
                          .doc() // for new document
                          .set({   // set value
                        "createdAt": DateTime.now(),
                        "note": note,
                        "userId": userId?.uid,
                        // "phone" : userPhone,
                      });
                    } catch (e) {
                      print("Error $e");
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>homeSceen()));
                  }else{
                    print("empty note");
                  }
                },
                child: Center(child: Text("Add Note")))
          ],
        ),
      ),
    );
  }
}
