import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/edit_notes.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';

class Display_Notes extends StatefulWidget {
  @override
  Display_NotesState createState() => Display_NotesState();
}

class Display_NotesState extends State<Display_Notes> {
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  Display_NotesState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: ref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditNotePage()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            border: Border.all(
                                color: Colors.black12.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.shade100,
                                  blurRadius: 1,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0, 2.0))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['title'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              doc['description'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w100,
                              ),
                              maxLines: 7,
                            ),
                          ],
                        ),
                      ),
                    ));
              }).toList(),
            );
            /*Padding(
                  padding: EdgeInsets.all(0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditNotePage(editDocument: doc)));
                    },
                  ),
                );*/
          }),
    );
    // TODO: implement build
  }
}
