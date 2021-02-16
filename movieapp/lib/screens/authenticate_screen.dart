import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/screens/home_screen.dart';
import '../services/authentication.dart';
import '../animations/loading_widget.dart';
import '../configurations/sizeConfigs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/services/authentication.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    var _textSize = MediaQuery.of(context).textScaleFactor;
    var _borderRadius = Radius.circular(20);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/EmeraldLogo.svg',
                          height: constraints.maxHeight / 1.2,
                        ),
                        Text(
                          'Welcome!',
                          style: TextStyles.logInWelcome,
                        )
                      ],
                    );
                  },
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  //color: Colors.orange,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(_borderRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.transparent),
                        width: _screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/google-icon.svg',
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    'Log in with Google ',
                                    style: TextStyles.logInElementsBlack,
                                    maxLines: 3,
                                  )
                                ],
                              ),
                              onPressed: () {
                                LocalUser.instance.signInWithGoogle();
                              },
                            ),
                            OutlineButton(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.questionCircle,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    'Log in Anonymously ',
                                    style: TextStyles.logInElementsWhite,
                                    maxLines: 3,
                                  )
                                ],
                              ),
                              onPressed: () {
                                LocalUser.instance.singInAnonymously();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Welcome to Emerald Movies App 2.0! You can purchase tickets, Buy snacks, and view upcoming movies all in one app!',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Raleway'),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
