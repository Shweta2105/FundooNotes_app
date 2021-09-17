import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  CollectionReference data = FirebaseStorage.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    uploadData(String title) async {
      List<String> splitList = title.split(' ');
      List<String> indexList = [];

      for (int i = 0; i < splitList.length; i++) {
        for (int j = 0; j < splitList[i].length + i; j++) {
          indexList.add(splitList[i].substring(0, j).toLowerCase());
        }
      }
      data.add({'notes': title, 'index': indexList});
    }

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => searchController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    hintText: 'Search here',
                    hintStyle:
                        TextStyle(fontFamily: 'Antra', color: Colors.blueGrey)),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                uploadData(searchController.text);
              },
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
