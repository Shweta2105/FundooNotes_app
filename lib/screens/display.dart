import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fundo_notes/screens/edit_notes.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';

class Display_Notes extends StatefulWidget {
  @override
  Display_NotesState createState() => Display_NotesState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('notes');

class Display_NotesState extends State<Display_Notes> {
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
                                builder: (context) =>
                                    EditNotePage(docToEdit: doc)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
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
          }),
    );
  }
}

Widget GridviewNotes() {
  return Scaffold(
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditNotePage(docToEdit: doc)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black54.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(8),
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 5,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  doc['description'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ]),
                        )));
              }).toList(),
            );
          }));
}

//Widget GridviewNotes(BuildContext context) {

  /*  child:
                        snapshot.data!.docs.map((doc) {
                          return Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 150,
                                color: Colors.grey[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doc['title'],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                              ));
                        });*/


