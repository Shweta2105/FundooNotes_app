import 'dart:convert';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends BaseScreen {
  @override
  // ignore: unnecessary_new
  LoginPageState createState() => new LoginPageState();
}

//late SharedPreferences localStorage;

class LoginPageState extends BaseScreenState {
  final databaseReference = FirebaseFirestore.instance;

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  TextEditingController emailController = TextEditingController();
  FocusNode passwordFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  TextEditingController passwordController = TextEditingController();
  bool emailValid = true;
  bool passwordValid = true;
  RegExp emailRegExp = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordRegExp =
      new RegExp(r"^(?=.*?[0-9a-zA-Z])[0-9a-zA-Z]*[@#$%!][0-9a-zA-Z]*$");

  final firestoreInstance = FirebaseFirestore.instance;

  late SharedPreferences logindata;
  late bool newuser;
  Future<void> getData() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen()));
    }
  }

  _submit() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('user');
    final SnapShot = collection.snapshots().map((SnapShot) => SnapShot.docs
        .where((doc) =>
            doc['email'] == emailController.text ||
            doc['password'] == passwordController.text));
    return (await SnapShot.first).toList();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    getData();
    super.initState();
  }

  _emailRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocus);
    });
  }

  _passwordRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocus);
    });
  }

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: HexColor('#FFFFFF'),
      title: Text('FundoNotes Login',
          style: TextStyle(
            color: HexColor('#96C3EB'),
            fontWeight: FontWeight.w500,
            fontSize: 25,
            fontStyle: FontStyle.italic,
          )),
      centerTitle: true,
    );
  }

  @override
  Widget getBody(BuildContext context) {
    SnackBar snackBar;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Card(
                color: HexColor('#FFFFFF'),
                elevation: 10,
                child: Container(
                  height: 100,
                  width: 135,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset('assets/Images/fundooIcon.jpg'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: emailController,
                focusNode: emailFocus,
                onTap: _emailRequestFocus,
                onChanged: (value) {
                  if (emailRegExp.hasMatch(value)) {
                    emailValid = true;
                  } else {
                    emailValid = false;
                  }
                  setState(() {});
                },
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: HexColor('#606E74')),
                decoration: InputDecoration(
                    labelText: 'Email Id',
                    errorText: emailValid ? null : "Invalid email",
                    errorStyle: const TextStyle(fontSize: 15),
                    labelStyle: TextStyle(
                        color: emailFocus.hasFocus
                            ? emailValid
                                ? Colors.amberAccent
                                : Colors.red
                            : HexColor('#658292')),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#658292'))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: emailFocus.hasFocus
                          ? const BorderSide(color: Colors.amber, width: 1.2)
                          : BorderSide(color: HexColor('#658292')),
                    )),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                child: SizedBox(
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    focusNode: passwordFocus,
                    onTap: _passwordRequestFocus,
                    onChanged: (value) {
                      if (passwordRegExp.hasMatch(value)) {
                        passwordValid = true;
                      } else {
                        passwordValid = false;
                      }
                      setState(() {});
                    },
                    style: new TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: HexColor('#606E74')),
                    decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: passwordValid ? null : "Invalid password",
                        errorStyle: const TextStyle(fontSize: 15),
                        labelStyle: TextStyle(
                            color: passwordFocus.hasFocus
                                ? passwordValid
                                    ? Colors.amberAccent
                                    : Colors.red
                                : HexColor('#658292')),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#658292'))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          borderSide: passwordFocus.hasFocus
                              ? const BorderSide(
                                  color: Colors.amber, width: 1.2)
                              : BorderSide(color: HexColor('#658292')),
                        )),
                  ),
                ),
              ),
            ),
            FlatButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/forgot_password')
                      //forgot password screen
                    },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    // ignore: prefer_const_constructors
                    Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Login',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                    onPressed: () async {
                      _submit();
                      String Email = emailController.text;
                      String password = passwordController.text;
                      FirebaseFirestore.instance
                          .collection('users')
                          .get()
                          .then((querySnapshot) {
                        querySnapshot.docs.forEach((docs) {
                          print(docs["emailId"]);
                          print(docs.id);
                          print(docs["password"]);

                          if ((docs["emailId"] != '') &&
                              (docs["password"] != '')) {
                            print("user login successful");
                            logindata.setBool('login', false);

                            logindata.setString('emailId', Email);
                            snackBar = SnackBar(
                              content: Text("successfull login"),
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        HomeScreen()));
                          } else {
                            snackBar = SnackBar(
                              content: Text("login failed..!!"),
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        LoginPage()));
                          }
                        });
                      });
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString('email', emailController.text);
                    })),
            Container(
                child: Row(
              children: <Widget>[
                Text('Does not have account?'),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup_page');
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
          ],
        ),
      ),
    );
  }
}
