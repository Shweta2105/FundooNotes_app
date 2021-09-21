import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundo_notes/utils/navigationDrawer.dart';

class DeleteNotePage extends StatefulWidget {
  @override
  _DeleteNotePageState createState() => _DeleteNotePageState();
}

class _DeleteNotePageState extends State<DeleteNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Padding(
              padding: EdgeInsets.fromLTRB(2, 5, 2, 10),
              child: Material(
                color: Colors.white10,
                child: Row(children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 25,
                      ),
                      color: Colors.black.withOpacity(0.7),
                      onPressed: () {
                        NavigationDrawer();
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Deleted",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 200.0),
                  IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        size: 25,
                      ),
                      color: Colors.black.withOpacity(0.7),
                      onPressed: () {}),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
