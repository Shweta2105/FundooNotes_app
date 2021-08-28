import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends BaseScreen {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends BaseScreenState {
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_power,
              )),
          CircleAvatar(),
        ],
      ),
      body: const Center(child: Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: const Icon(
            Icons.add_circle,
            color: Colors.blue,
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.photo)),
        ],
      ),
    );
  }
}
