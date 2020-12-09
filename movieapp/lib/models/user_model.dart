import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/database.dart';
import 'package:flutter/material.dart';

class LocalUser extends ChangeNotifier {
  String uid;
  String username;
  String role;
  List<dynamic> preferences;
  int points;

  LocalUser._privateConstructor();
  static final LocalUser instance = LocalUser._privateConstructor();

  LocalUser get user {
    if (user != null) {
      return user;
    }
  }

  LocalUser(
      {this.uid, this.preferences, this.username, this.role, this.points});

  // LocalUser.fromData(Map<String, dynamic> data)
  //     : uid = data['id'],
  //       username = data['name'],
  //       preferences = data['preferences'],
  //       role = data['role'];
}
