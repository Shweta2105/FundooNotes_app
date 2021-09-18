import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'display.dart';

class EditNotePage extends BaseScreen {
  EditNotePageState createstate() => new EditNotePageState();
  late final String title;
  late final String color;
  late DocumentSnapshot docToEdit;
  EditNotePage({required this.docToEdit});
}

class EditNotePageState extends State<EditNotePage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController notes_Controller = new TextEditingController();
  bool pinn = false;
  bool archieve = false;
  bool delete = false;
  String reminder = '';
  Color _color = Colors.white;
  late String emailId;

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
      text: widget.docToEdit['title'],
    );
    notes_Controller = TextEditingController(
      text: widget.docToEdit['description'],
    );
    String colorTesting = widget.docToEdit['editColor'].toString();
    String valueString = colorTesting.split('(0x')[1].split(')')[0];
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
        //automaticallyImplyLeading: false,
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
                        onPressed: () async {
                          Database.updateItem(
                              //docId: widget.documentId,
                              title: titleController.text,
                              content: notes_Controller.text,
                              archive: archieve,
                              delete: delete,
                              pin: pinn,
                              color: '$_color',
                              userEmail: '$emailId');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Display_Notes()));
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                    IconButton(
                      icon: Icon(pinn
                          ? Icons.push_pin_rounded
                          : Icons.push_pin_outlined),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          pinn = !pinn;
                        });
                      },
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notification_add_outlined,
                          color: Colors.black,
                        )),
                    IconButton(
                      icon: Icon(archieve
                          ? Icons.archive_rounded
                          : Icons.archive_outlined),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          archieve = !archieve;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
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
                    fontSize: 20,
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
