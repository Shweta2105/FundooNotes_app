import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:fundo_notes/screens/create_note.dart';
import 'package:fundo_notes/screens/display.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends BaseScreen {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends BaseScreenState {
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  void initState() {
    super.initState();
  }
  /* Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.list_sharp,
              color: Colors.black,
            )),
        CircleAvatar()
      ],
    );
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        backgroundColor: HexColor('#FFFFFF'),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.grid_view,
                color: Colors.black,
              )),
          CircleAvatar(),
        ],
      ),
      body: Display_Notes(),
      /* Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    'loading',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black12,
                    ),
                  ),
                );
              } else {
                return ListView.builder(itemBuilder: itemBuilder)
                 GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount:
                        snapshot.hasData ? snapshot.data!.docs.length : 0,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        height: 150,
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            // Text(snapshot.data!.docs[index].data['title'])
                          ],
                        ),
                      );
                    });
              }
            }),
      ),*/

      //backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Create_note())),
                // Add your onPressed code here!
              },
          child: const Icon(
            Icons.add,
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_box,
                    size: 25,
                    color: Colors.black,
                  )),
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
                    Icons.mic_none_outlined,
                    size: 25,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.photo,
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
