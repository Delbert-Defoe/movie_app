import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/screens/home_screen.dart';
import '../services/authentication.dart';
import '../animations/loading_widget.dart';
import '../configurations/sizeConfigs.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    final AuthService _auth = AuthService();
    return SafeArea(
      child: Scaffold(
        body: Column(
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
              flex: 6,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(_borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400.withOpacity(0.4)),
                      width: _screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              print('Hello');
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
              child: Text(''),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
