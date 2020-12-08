import 'package:flutter/material.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:movieapp/models/movies_model.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/auth_wrapper.dart';
import 'package:movieapp/services/auth_wrapper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserModel>(context);
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                logOutDialog(context);
              })
        ],
      ),
      body: Container(
        width: devWidth,
        height: devHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green[500], Colors.black],
                end: Alignment.centerLeft,
                begin: Alignment.bottomRight)),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[700]),
                  //clipBehavior: Clip.hardEdge,
                  height: devHeight / 3.5,
                  width: devWidth / 1.7,
                  child: Icon(
                    Icons.person,
                    size: devWidth / 1.7,
                  )),
            ),
            userProvider.user == null
                ? Center(
                    child: Text(
                      'You are not currently Logged in',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                      'Ryan Defoe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.green[900], Colors.green[400]])),
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Points: ',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      ' 500 ',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.green[100],
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )),
            Container(
              height: devHeight * 0.6,
              width: devWidth,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Attended Movies:',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: (460), maxWidth: devWidth - 10),
                    child: ListView(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void logOutDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Log out',
        style: TextStyle(color: Colors.black),
      ),
      content: Text('Are you sure you want to Log Out?',
          style: TextStyle(color: Colors.black)),
      elevation: 6,
      backgroundColor: Colors.white,
      actions: [
        FlatButton(
          child: Text(
            'No',
            style: TextStyle(color: Colors.green[600]),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
            child: Text('Yes', style: TextStyle(color: Colors.green[600])),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
              AuthService().signout();
            })
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
