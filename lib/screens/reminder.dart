import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/create_note.dart';
import 'package:fundo_notes/utils/navigationDrawer.dart';

class ReminderNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white10,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Material(
                            color: Colors.white10,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  Text(
                                    "Reminders",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 140.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {
                                        TextFormField(
                                            decoration:
                                                InputDecoration.collapsed(
                                              hintText: "Search your notes",
                                            ),
                                            onChanged: (value) {});
                                      }),
                                  SizedBox(width: 2.0),
                                  IconButton(
                                      icon: Icon(
                                        Icons.view_agenda_outlined,
                                        size: 25,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      onPressed: () {}),
                                  SizedBox(width: 2.0)
                                ])))))),
        drawer: NavigationDrawer(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/reminder[1].png",
            width: 120,
            height: 120,
          ),
          SizedBox(
            height: 15,
          ),
          Text("Notes with upcoming reminders appear here"),
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Create_note()));
                  },
                  icon: Image.asset("assets/images/addIcon.png"))),
          foregroundColor: Colors.amber,
          focusColor: Colors.white10,
          hoverColor: Colors.green,
          backgroundColor: Colors.white,
          splashColor: Colors.tealAccent,
        ),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            child: Container(
              width: 80,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.brush_outlined,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.mic,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.crop_original,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      onPressed: () {}),
                ],
              ),
            )));
  }
}
