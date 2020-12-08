import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/database.dart';
import 'package:flutter/material.dart';

class LocalUser {
  String uid;
  String username;
  String role;
  List<dynamic> preferences;
  int points;

  LocalUser user;

  LocalUser(
      {this.uid, this.preferences, this.username, this.role, this.points});

  LocalUser.fromData(Map<String, dynamic> data)
      : uid = data['id'],
        username = data['name'],
        preferences = data['preferences'],
        role = data['role'];
}

class UserModel extends ChangeNotifier {
  var user = new LocalUser();

  String name = 'Empty';
  String uid;
  String role;
  List<dynamic> preferences = [];

  void createUser(Map<String, dynamic> data) {
    if (data == null) {
      return;
    }
    user = LocalUser.fromData(data);
    name = user.username;
    // print(name);
    uid = user.uid;
    role = user.role;
    preferences = user.preferences;
  }

  Widget getUserName() {
    return Text('${name} i Now',
        style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            letterSpacing: 3,
            fontWeight: FontWeight.w600));
  }
}
