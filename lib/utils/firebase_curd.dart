import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore dataStore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = dataStore.collection("users");

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
}
