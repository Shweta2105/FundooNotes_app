// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/display.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerHeader(),
        createDrawerBodyItem(
          icon: Icons.lightbulb_outline,
          text: 'Notes',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Display_Notes()));
          },
        ),
        Divider(),
        createDrawerBodyItem(
          icon: Icons.notifications_outlined,
          text: 'Reminders',
          onTap: () {
            /*  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReminderPage()));*/
          },
        ),
        Divider(),
        createDrawerBodyItem(
          icon: Icons.add,
          text: 'Create new label',
          onTap: () {},
        ),
        Divider(),
        createDrawerBodyItem(
          icon: Icons.archive_outlined,
          text: 'Archive',
          onTap: () {
            /*  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArchivePage()));*/
          },
        ),
        Divider(),
        createDrawerBodyItem(
          icon: Icons.delete_outline,
          text: 'Deleted',
          onTap: () {
            /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeleteNotesPage()));*/
          },
        ),
        Divider(),
      ],
    ));
  }

  Widget createDrawerHeader() {
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(top: 5),
      child: DrawerHeader(
          child: Text("Fundoo Notes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ))),
    );
  }

  Widget createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
