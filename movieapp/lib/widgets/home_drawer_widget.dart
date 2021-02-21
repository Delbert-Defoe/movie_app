import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
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
    String role = LocalUser.instance.role;

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
          if (role == 'user') ..._getUserList(context),
          if (role == 'admin') ..._getAdminList(context),
          if (role == 'dev' || role == 'user') ..._getAdminList(context),
          if (role == 'dev' || role == 'admin') ..._getUserList(context)
        ]),
      ),
    );
  }

  List<Widget> _getUserList(BuildContext context) {
    return [
      ListTile(
        leading: Icon(
          Icons.movie_filter,
          color: Colors.black,
        ),
        title: Text(
          'My Tickets',
          style: TextStyles.drawerElements,
        ),
        onTap: () {
          Navigator.pushNamed(context, '/tickets_screen');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.fastfood,
          color: Colors.black,
        ),
        title: Text('Snacks', style: TextStyles.drawerElements),
        onTap: () {
          Navigator.pushNamed(context, '/snack_screen');
        },
      ),
      ListTile(
        leading: Icon(Icons.person, color: Colors.black),
        title: Text('Profile', style: TextStyles.drawerElements),
        onTap: () {
          Navigator.pushNamed(context, '/profile_screen');
        },
      ),
    ];
  }

  List<Widget> _getAdminList(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.settings, color: Colors.black),
        title: Text('Manage Movies', style: TextStyles.drawerElements),
        onTap: () {
          Navigator.pushNamed(context, '/manage_movie_screen');
        },
      ),
      ListTile(
        leading: Icon(Icons.settings, color: Colors.black),
        title: Text('Manage Snacks', style: TextStyles.drawerElements),
      ),
      ListTile(
        leading: Icon(Icons.settings, color: Colors.black),
        title: Text('Scan Tickets', style: TextStyles.drawerElements),
      ),
      ListTile(
        leading: Icon(Icons.settings, color: Colors.black),
        title: Text('View Orders', style: TextStyles.drawerElements),
      ),
    ];
  }
}
