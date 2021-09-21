//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fundo_notes/screens/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';

class UploadedPackage extends StatefulWidget {
  @override
  _UploadedPackageState createState() => _UploadedPackageState();
}

class _UploadedPackageState extends State<UploadedPackage> {
  final _storage = FirebaseStorage.instance;
  late SharedPreferences UserData;
  final _picker = ImagePicker();
  var imageUrl;
  var email;
  String? _image;

  late Future<File> imageFile;
  @override
  void initState() {
    super.initState();
    getEmailData();
    uploadImage();
  }

  void getEmailData() async {
    UserData = await SharedPreferences.getInstance();
    setState(() {
      email = UserData.getString('emailId')!;
      print('emailId: $email');
    });
  }

  selectImage() async {
    File imageFile;
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
    var _fileName = basename(imageFile.path);

    if (imageFile != null) {
      var snapshot = await _storage.ref().child(_fileName).putFile(imageFile);

      var downloadedUrl = await snapshot.ref.getDownloadURL();
      SharedPreferences saveimage = await SharedPreferences.getInstance();
      saveimage.setString("image", downloadedUrl);
      setState(() {
        imageUrl = downloadedUrl;
      });
      print('imageurl:' '$imageUrl');
      print("filename: $_fileName");
    } else {
      print("No path received");
    }
  }

  getAndUpdateImage() {
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((docs) async {
        print(docs["emailId"]);
        print(docs.id);

        if (docs['emailId'] == email) {
          //updateUrl(docId: docs.reference.id, image: imageUrl);
          uploadImage();
          print(docs.id);
          print(email);
        } else {
          print(" Notes not updated");
        }
      });
    });
  }

  void uploadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    print("getImage");
    print(saveimage.getString("image"));
    setState(() {
      _image = saveimage.getString("image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () async {
              UserData.setBool('login', true);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: ImageGet(),
    );
  }

  Widget ImageGet() {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Profile Picture",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              // padding: EdgeInsets.only(left: 10),
              child: Text(
                "Add profile picture for identity",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              // padding: EdgeInsets.only(left: 10),
              child: Text(
                "You can change it Whenever you need to change",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),

            SizedBox(
              height: 60,
            ),
            //_imagePath != null
            _image != null
                ? CircleAvatar(
                    radius: 110, backgroundImage: NetworkImage(_image!))
                : CircleAvatar(
                    radius: 110,
                    child: Icon(Icons.person),
                  ),
            // width: size * 2, height: size * 2, fit: BoxFit.cover),
            // radius: size,

            SizedBox(
              height: 30,
            ),
            FlatButton(
                onPressed: () {
                  selectImage();
                },
                child: Container(
                  width: 300,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      Icon(Icons.add_a_photo_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add profile picture")
                    ],
                  ),
                  color: Colors.cyan,
                )),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                onPressed: () {
                  getAndUpdateImage();
                },
                //updateUrlInFirebase();
                child: Container(
                  width: 300,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                      ),
                      Text("Save profile picture")
                    ],
                  ),
                  color: Colors.cyan,
                )),
          ]),
        ),
      ),
    );
  }
}
