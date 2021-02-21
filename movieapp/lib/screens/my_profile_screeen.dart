import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/main.dart';

import 'package:movieapp/models/movies_model.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/auth_wrapper.dart';
import 'package:movieapp/services/auth_wrapper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;
    var headerHeight = devHeight / 3;
    return SafeArea(
        child: LocalUser.instance.username == null
            ? AnonUser()
            : SignedUpUser(devWidth: devWidth, devHeight: devHeight));
  }
}

class AnonUser extends StatelessWidget {
  const AnonUser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyles.pagetitle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green, Colors.black],
                end: Alignment.center,
                begin: Alignment.bottomCenter)),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Log in now to save your favourite movies and accumulate points!',
                    style: TextStyles.profileScreenTitles,
                    textAlign: TextAlign.center,
                  ),
                ),
                IntrinsicWidth(
                  child: RaisedButton(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/google-icon.svg',
                          height: 30,
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Log in with Google ',
                            style: TextStyles.logInElementsBlack,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                    onPressed: () async {
                      await LocalUser.instance.signout();
                      await LocalUser.instance.signInWithGoogle();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class SignedUpUser extends StatelessWidget {
  const SignedUpUser({
    Key key,
    @required this.devWidth,
    @required this.devHeight,
  }) : super(key: key);

  final double devWidth;
  final double devHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyles.pagetitle,
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
                colors: [Colors.green, Colors.black],
                end: Alignment.center,
                begin: Alignment.bottomCenter)),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    child: Icon(Icons.person, size: 150, color: Colors.black),
                  ),
                  Text(
                    LocalUser.instance.username,
                    style: TextStyles.profileScreenTitles,
                  )
                ]),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Points: ',
                    style: TextStyles.profileScreenTitles,
                  ),
                  Text(
                    LocalUser.instance.points.toString(),
                    style: TextStyles.profileScreenValues,
                  )
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    'Favourite Genres: ',
                    style: TextStyles.profileScreenTitles,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...LocalUser.instance.preferences
                            .map((pref) => _prefText(pref))
                      ]),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.green,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Movies Attended: ',
                      style: TextStyles.profileScreenTitles,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Black Widow',
                            style: TextStyles.profileScreenValues),
                        Text('Jumanji The Next Level ',
                            style: TextStyles.profileScreenValues),
                        Text('John Wick 3',
                            style: TextStyles.profileScreenValues),
                        Text('Bad Boys For Life',
                            style: TextStyles.profileScreenValues),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void logOutDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text(
      'Log out',
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w800),
    ),
    content: Text('Are you sure you want to Log Out?',
        style: TextStyle(color: Colors.black, fontFamily: 'Raleway')),
    elevation: 6,
    backgroundColor: Colors.white,
    actions: [
      FlatButton(
        child: Text(
          'No',
          style: TextStyle(color: Colors.green[600], fontFamily: 'Raleway'),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FlatButton(
          child: Text('Yes',
              style:
                  TextStyle(color: Colors.green[600], fontFamily: 'Raleway')),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
            LocalUser.instance.signout();
          })
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

Widget _prefText(String pref) {
  return Text(pref, style: TextStyles.profileScreenValues);
}
