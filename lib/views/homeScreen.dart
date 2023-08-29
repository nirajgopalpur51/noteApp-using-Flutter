import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/createNewScreen.dart';
import 'package:note_app/views/signInScreen.dart';
import 'editNoteScreen.dart';

class homeSceen extends StatefulWidget {
  const homeSceen({Key? key}) : super(key: key);

  @override
  State<homeSceen> createState() => _homeSceenState();
}

class _homeSceenState extends State<homeSceen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homescreen"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => loginScreen());
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Container(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("userId,isEqual:userId.uid")
            .snapshots(),
             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data found"));
          }
          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data!.docs[index]["note"];
                  var noteId = snapshot.data!.docs[index]["userId"];
                  var docId = snapshot.data!.docs[index].id;
                  return Card(
                    child: ListTile(
                      title: Text(note),
                      subtitle: Text(noteId),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.to(() => editNoteScreen(), arguments: {
                                  "note": note,
                                  "docId": docId,
                                });
                              },
                              child: Icon(Icons.edit)),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection("notes")
                                    .doc(docId)
                                    .delete();
                              },
                              child: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => createNotesScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
