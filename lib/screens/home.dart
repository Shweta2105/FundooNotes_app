import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:fundo_notes/screens/create_note.dart';
import 'package:fundo_notes/screens/display.dart';
import 'package:fundo_notes/screens/searchpage.dart';
import 'package:fundo_notes/utils/navigationDrawer.dart';
import 'package:fundo_notes/utils/uploads_images.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends BaseScreen {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

bool view = false;

class HomeScreenState extends BaseScreenState {
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  late String searchString;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#FFFFFF'),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 1.0,
                        )
                      ]),
                  child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 6),
                      child: Material(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_constructors

                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onPressed: () =>
                                  _scaffoldKey.currentState!.openDrawer(),
                            ),
                            SizedBox(
                              width: 0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchNotes()));
                                },
                                child: Text(
                                  "Search your notes",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )),
                            SizedBox(
                              width: 55,
                            ),
                            IconButton(
                              icon: Icon(view
                                  ? Icons.list_rounded
                                  : Icons.grid_view_outlined),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  view = !view;
                                });
                              },
                            ),
                            IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UploadedPackage())),
                                icon: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                )),
                          ],
                        ),
                      ))))),
      body: _changeView(),
      drawer: NavigationDrawer(),

      //backgroundColor: Colors.white,

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Create_note()));
                },
                icon: Image.asset("assets/Images/addIcon.jpg"))),
        foregroundColor: Colors.amber,
        focusColor: Colors.white10,
        hoverColor: Colors.green,
        backgroundColor: Colors.white,
        splashColor: Colors.tealAccent,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_box_outlined,
                    size: 25,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.color_lens_outlined,
                    size: 25,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mic_none_outlined,
                    size: 25,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.photo_album_outlined,
                    size: 25,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

_changeView() {
  if (view == false) {
    return Display_Notes();
  } else {
    return GridviewNotes();
  }
}
