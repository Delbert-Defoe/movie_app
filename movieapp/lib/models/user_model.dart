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

  LocalUser._internal();
  static final LocalUser instance = LocalUser._internal();

  factory LocalUser() {
    if (instance == null) {}
    return instance;
  }

  // LocalUser.fromData(Map<String, dynamic> data)
  //     : uid = data['id'],
  //       username = data['name'],
  //       preferences = data['preferences'],
  //       role = data['role'];
}
