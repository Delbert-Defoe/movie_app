import 'package:flutter/material.dart';
import 'package:movieapp/screens/authenticate_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/models/ticket_model.dart';
import 'package:movieapp/models/items_model.dart';
import './local_database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<LocalUser>(context);
    if (user == null) {
      //LocalDatabase.instance.initiateDatabase();
      return HomeScreen();
    } else {
      return AuthScreen();
    }
  }
}
