import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:fundo_notes/screens/colors.dart';
import 'package:fundo_notes/screens/deleteNote.dart';
import 'package:fundo_notes/screens/home.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'display.dart';

class EditNotePage extends BaseScreen {
  DocumentSnapshot editDocument;
  late final String title;
  late final Color color;
  late final String documentId;

  EditNotePage({
    required this.editDocument,
  });

  EditNotePageState createstate() => new EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  FocusNode myFocusNode = new FocusNode();
  bool pinn = false;
  bool archive = false;
  bool delete = false;
  //String reminder = '';
  late Color _color = Colors.white;
  var otherColor;
  late String emailId;
  TextEditingController titleController = TextEditingController();
  TextEditingController notes_Controller = TextEditingController();

  void getLoginData() async {
    var loginData = await SharedPreferences.getInstance();
    setState(() {
      emailId = loginData.getString('emailId')!;
      print('UserEmail:$emailId');
      print('_color:$_color');
    });
  }

  @override
  void initState() {
    titleController = TextEditingController(
      text: widget.editDocument['title'],
    );
    notes_Controller = TextEditingController(
      text: widget.editDocument['content'],
    );
    String testingColorString = widget.editDocument['color'].toString();
    String valueString = testingColorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    _color = otherColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color,
        appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: _color),
            backgroundColor: _color,
            elevation: 0.0,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Material(
                            color: _color,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () async {
                                        await widget.editDocument.reference
                                            .update({
                                          //'docId': widget.documentId,
                                          'title': titleController.text,
                                          'content': notes_Controller.text,
                                          'archive': archive,
                                          'delete': delete,
                                          'pin': pinn,
                                          'color': '$_color',
                                          'userEmail': '$emailId'
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      }),
                                  SizedBox(width: 190.0),
                                  IconButton(
                                    icon: Icon(
                                      pinn
                                          ? Icons.push_pin
                                          : Icons.push_pin_outlined,
                                      size: 25,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        pinn = !pinn;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_alert_outlined,
                                      size: 25,
                                    ),
                                    color: Colors.black.withOpacity(0.7),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading: new Icon(
                                                      Icons.access_time),
                                                  title:
                                                      new Text('Later today'),
                                                  trailing: Text('18:00'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: new Icon(
                                                      Icons.access_time),
                                                  title: new Text(
                                                      'Later tomorrow'),
                                                  trailing: Text('08:00'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                    leading: new Icon(
                                                        Icons.access_time),
                                                    title: new Text(
                                                        'Choose a date & time'),
                                                    onTap: () {}),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.archive_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        setState(() {
                                          archive = !archive;
                                        });
                                        var title = titleController.text;
                                        var content = notes_Controller.text;
                                        if (title.isEmpty && content.isEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));
                                        } else {
                                          widget.editDocument.reference.update({
                                            //'docId': widget.documentId,
                                            'title': titleController.text,
                                            'content': notes_Controller.text,
                                            'archive': archive,
                                            'delete': delete,
                                            'pin': pinn,
                                            'color': '$_color',
                                            'userEmail': '$emailId'
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));
                                          var snackBar = SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Row(children: [
                                              Text(
                                                "Note Archive",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 180,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  "Undo",
                                                  style: TextStyle(
                                                      color: Colors.orange),
                                                ),
                                              )
                                            ]),
                                            duration: Duration(
                                                seconds: 2, milliseconds: 250),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }),
                                ])))))),
        body: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
                child: Column(children: [
                  TextField(
                    controller: titleController,
                    focusNode: myFocusNode,
                    cursorColor: Colors.black54,
                    maxLines: 1,
                    style: TextStyle(
                      height: 1,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: notes_Controller,
                    cursorColor: Colors.black54,
                    maxLines: 10,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note',
                        hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        helperStyle: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                ]),
                padding: EdgeInsets.all(20))),
        bottomNavigationBar: BottomAppBar(
            color: _color,
            child: Container(
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 25,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: new Icon(Icons.photo_camera),
                                      title: new Text('Take photo'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.crop_original),
                                      title: new Text('Add image'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.brush_outlined),
                                      title: new Text('Drawing'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.mic),
                                      title: new Text('Recording'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading:
                                          new Icon(Icons.check_box_outlined),
                                      title: new Text('Tick boxes'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: _color,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 120,
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Color_slider(
                                        onSelectColor: (value) {
                                          print(value);
                                          setState(() {
                                            _color = value;
                                          });
                                        },
                                        availableColors: [
                                          Colors.white,
                                          Colors.blueAccent,
                                          Colors.redAccent,
                                          Colors.yellowAccent,
                                          Colors.pinkAccent,
                                          Colors.purpleAccent,
                                          Colors.orangeAccent,
                                          Colors.indigoAccent,
                                          Colors.cyan,
                                          Colors.brown,
                                          Colors.blueGrey,
                                          Colors.green,
                                        ],
                                        initialColor: Colors.white,
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.color_lens_outlined,
                            size: 25,
                            color: Colors.black.withOpacity(0.7),
                          )),
                      SizedBox(
                        width: 230,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: 25,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                        leading: new Icon(Icons.delete_sharp),
                                        title: new Text('Delete'),
                                        onTap: () async {
                                          setState(() {
                                            delete = !delete;
                                          });
                                          {
                                            await widget.editDocument.reference
                                                .update({
                                              //'docId': widget.documentId,
                                              'title': titleController.text,
                                              'content': notes_Controller.text,
                                              'archive': archive,
                                              'delete': delete,
                                              'pin': pinn,
                                              'color': '$_color',
                                              'userEmail': '$emailId'
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeleteNotePage()));
                                            var snackBar = SnackBar(
                                              backgroundColor: Colors.black,
                                              content: Row(children: [
                                                Text(
                                                  "Note moved to Bin ",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 180,
                                                ),
                                                InkWell(
                                                  child: Text("Undo",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.orange)),
                                                ),
                                              ]),
                                              duration: Duration(
                                                  seconds: 2,
                                                  milliseconds: 250),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        }),
                                    ListTile(
                                      leading: new Icon(Icons.filter_none),
                                      title: new Text('Make a copy'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.share),
                                      title: new Text('Send'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.person_add_alt),
                                      title: new Text('Collaborator'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(
                                        Icons.label,
                                      ),
                                      title: new Text('Labels'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ]))));
  }
}
