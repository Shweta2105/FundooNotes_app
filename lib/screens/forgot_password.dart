import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/base_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class Forgot_Password extends BaseScreen {
  @override
  Forgot_PasswordScreen createState() => new Forgot_PasswordScreen();
}

class Forgot_PasswordScreen extends BaseScreenState {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  TextEditingController emailController = TextEditingController();
  FocusNode? emailFocus = new FocusNode();
  bool emailValid = true;
  RegExp emailRegExp = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  void initState() {
    super.initState();
  }

  _emailRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocus);
    });
  }

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: HexColor('#FFFFFF'),
      title: Text('FundoNotes Forgot Password',
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
                child: Text(
                  '',
                  style: TextStyle(
                    color: HexColor('#96C3EB'),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
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
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  child: SizedBox(
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
                          labelText: 'Password',
                          errorText: emailValid ? null : "Invalid password",
                          errorStyle: const TextStyle(fontSize: 15),
                          labelStyle: TextStyle(
                              color: emailFocus!.hasFocus
                                  ? emailValid
                                      ? Colors.amberAccent
                                      : Colors.red
                                  : HexColor('#658292')),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#658292'))),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            borderSide: emailFocus!.hasFocus
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Login'),
                    onPressed: () {
                      print(emailController.text);
                      FirebaseFirestore.instance
                          .collection('users')
                          .get()
                          .then((querySnapshot) {
                        querySnapshot.docs.forEach((docs) {
                          print(docs["emailId"]);
                        });
                      });
                    },
                  )),
            ],
          )),
    );
  }
}
