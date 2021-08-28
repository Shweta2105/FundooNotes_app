import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fundo_notes/utils/firebase_curd.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fundo_notes/screens/base_screen.dart';

class SignUpPage extends BaseScreen {
  @override
  SignUpPageState createState() => new SignUpPageState();
}

class SignUpPageState extends BaseScreenState {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode fnameFocus = new FocusNode();
  FocusNode lnameFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool fnameValid = true;
  bool lnameValid = true;
  bool emailValid = true;
  bool passwordValid = true;
  bool matchPassword = true;
  RegExp emailRegExp = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordRegExp =
      new RegExp(r"^(?=.*?[0-9a-zA-Z])[0-9a-zA-Z]*[@#$%!][0-9a-zA-Z]*$");

  void initState() {
    fnameController = TextEditingController();
    super.initState();
  }

  _fnameRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(fnameFocus);
    });
  }

  _lnameRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(lnameFocus);
    });
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

  // ignore: prefer_typing_uninitialized_variables
  late final snackBar;

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: HexColor('#FFFFFF'),
      title: Text('FundoNotes SignUp',
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
                  height: 80,
                  width: 105,
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
                controller: fnameController,
                focusNode: fnameFocus,
                onTap: _fnameRequestFocus,
                onChanged: (value) {
                  value.length <= 15 ? fnameValid = true : fnameValid = false;
                  setState(() {});
                },
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: HexColor('#606E74')),
                decoration: InputDecoration(
                    labelText: 'First Name',
                    errorText: fnameValid ? null : "Invalid first name",
                    errorStyle: const TextStyle(fontSize: 15),
                    labelStyle: TextStyle(
                        color: fnameFocus.hasFocus
                            ? fnameValid
                                ? Colors.amberAccent
                                : Colors.red
                            : HexColor('#658292')),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#658292'))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: fnameFocus.hasFocus
                          ? const BorderSide(color: Colors.amber, width: 1.2)
                          : BorderSide(color: HexColor('#658292')),
                    )),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: lnameController,
                focusNode: lnameFocus,
                onTap: _lnameRequestFocus,
                onChanged: (value) {
                  value.length <= 15 ? lnameValid = true : lnameValid = false;
                  setState(() {});
                },
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: HexColor('#606E74')),
                decoration: InputDecoration(
                    labelText: 'Last Name',
                    errorText: lnameValid ? null : "Invalid last name",
                    errorStyle: const TextStyle(fontSize: 15),
                    labelStyle: TextStyle(
                        color: lnameFocus.hasFocus
                            ? lnameValid
                                ? Colors.amberAccent
                                : Colors.red
                            : HexColor('#658292')),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#658292'))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: lnameFocus.hasFocus
                          ? const BorderSide(color: Colors.amber, width: 1.2)
                          : BorderSide(color: HexColor('#658292')),
                    )),
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
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
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
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text(
                    'SignUp',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    if (fnameController.text.isEmpty &&
                        lnameController.text.isEmpty &&
                        emailController.text.isEmpty) {
                      Navigator.pop(context);
                    } else {
                      await Database.addUser(
                          fname: fnameController.text,
                          lname: lnameController.text,
                          emailId: emailController.text,
                          password: passwordController.text);
                      Navigator.pop(context);
                    }
                    ;
                    {
                      final snackBar = SnackBar(
                        content: const Text('SuccessFully Signed in.. !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    ;

                    // print(fnameController.text);
                    //print(lnameController.text);
                    //print(emailController.text);
                    //print(passwordController.text);
                  },
                )),
            Container(
                child: Row(
              children: <Widget>[
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_page');
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
