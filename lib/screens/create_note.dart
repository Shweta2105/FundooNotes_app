import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';
import 'package:hexcolor/hexcolor.dart';

class Create_note extends BaseScreen {
  @override
  Create_note_state createState() => new Create_note_state();
}

class Create_note_state extends BaseScreenState {
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  TextEditingController titleController = new TextEditingController();
  TextEditingController notes_Controller = new TextEditingController();
  FocusNode titleFocus = new FocusNode();
  FocusNode notesFocus = new FocusNode();
  bool pinn = false;
  bool archieve = false;
  String reminder = '';
  String editColor = '';
  @override
  void initState() {
    titleController = TextEditingController();

    super.initState();
  }

  _titleRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(titleFocus);
    });
  }

  _notesRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(notesFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 215),
            child: IconButton(
                onPressed: () {
                  ref.add({
                    'title': titleController.text,
                    'description': notes_Controller.text,
                  }).whenComplete(() => Navigator.pop(context));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          IconButton(
              onPressed: () async {
                setState(() {
                  if (pinn == false) pinn = true;
                });
              },
              icon: Icon(
                Icons.push_pin_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notification_add_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () async {
                setState(() {
                  if (archieve == false) archieve = true;
                });
              },
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: TextFormField(
              controller: titleController,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: new TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 15,
                  color: HexColor('#606E74')),
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextFormField(
                controller: notes_Controller,
                maxLines: null,
                expands: true,
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: HexColor('#606E74')),
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
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
                    Icons.color_lens,
                    size: 25,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    size: 25,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
