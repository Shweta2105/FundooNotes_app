import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore dataStore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = dataStore.collection("users");
final CollectionReference _notesCollection = dataStore.collection("notes");

class Database {
  static String? userId;
  static Future<void> addUser({
    required String fname,
    required String lname,
    required String emailId,
    required String password,
  }) async {
    DocumentReference _documentReference = _mainCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "fname": fname,
      "lname": lname,
      "emailId": emailId,
      "password": password,
    };
    await _documentReference
        .set(data)
        .whenComplete(() => print("User added in firebase"))
        .catchError((e) => print(e));
  }

  static Future<void> updateUser({
    required String emailId,
    required String password,
  }) async {
    DocumentReference _documentReference = _mainCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "emailId": emailId,
      "password": password,
    };
    await _documentReference
        .update(data)
        .whenComplete(() => print("User Updated password in fiebase"))
        .catchError((e) => print(e));
  }

  static Future<void> createNewNote({
    // ignore: use_function_type_syntax_for_parameters

    required String title,
    required String description,
    required bool pinn,
    required String reminder,
    required bool archieve,
    required String editColor,
    required bool delete,
    required String emailId,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "pinn": pinn,
      "reminder": reminder,
      "archieve": archieve,
      "editColor": editColor,
      "delete": delete,
      "emailId": emailId,
    };
    await _notesCollection
        .add(data)
        .whenComplete(() => print("User added notes"))
        .catchError((e) => print(e));
  }
}
