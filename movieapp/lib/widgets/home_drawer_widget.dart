import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/my_tickets_screen.dart';
import 'package:movieapp/screens/snacks_screen.dart';
import 'package:movieapp/screens/my_profile_screeen.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/animations/pageRouteScaleAnimation.dart';
import 'package:movieapp/animations/pageRoutePushAnimation.dart';
import 'package:movieapp/models/movies_model.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double itemfontSize = 20;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor,
          Colors.black
        ], begin: Alignment.center, end: Alignment.bottomCenter)),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Image(
              image: AssetImage('assets/images/emeraldmoviesDP.png'),
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.movie_filter,
              color: Colors.black,
            ),
            title: Text(
              'My Tickets',
              style: TextStyle(color: Colors.black, fontSize: itemfontSize),
            ),
            onTap: () {
              Navigator.push(
                  context, ScaleAnimationTwo(widget: MyTicketsPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.fastfood,
              color: Colors.black,
            ),
            title: Text('Snacks',
                style: TextStyle(color: Colors.black, fontSize: itemfontSize)),
            onTap: () {
              Navigator.push(
                  context, ScaleAnimationTwo(widget: SnacksScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text('Profile',
                style: TextStyle(color: Colors.black, fontSize: itemfontSize)),
            onTap: () {
              //AuthService().signout();
              Navigator.push(
                  context, ScaleAnimationTwo(widget: ProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Add Movie',
                style: TextStyle(color: Colors.black, fontSize: itemfontSize)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Add Snack',
                style: TextStyle(color: Colors.black, fontSize: itemfontSize)),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Scan Ticket',
                style: TextStyle(color: Colors.black, fontSize: itemfontSize)),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('View Orders',
                style: TextStyle(color: Colors.black, fontSize: itemfontSize)),
          ),
        ]),
      ),
    );
  }
}
