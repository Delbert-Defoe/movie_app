import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movieapp/screens/home_screen.dart';
import '../services/authentication.dart';
import '../animations/loading_widget.dart';
import '../configurations/sizeConfigs.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var textSize = MediaQuery.of(context).textScaleFactor;

    final AuthService _auth = AuthService();
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                        /*gradient:
                      LinearGradient(colors: [Colors.green[800], Colors.green[500]])*/
                        color: Colors.black),
                    child: Stack(children: [
                      Image(
                        image:
                            AssetImage('assets/images/loginpagebackground.jpg'),
                      ),
                      Positioned(
                        top: screenHeight * 0.2371,
                        child: Container(
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 50, bottom: 50, left: 30, right: 30),
                          child: Column(
                            children: [
                              Text(
                                'Welcome!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize * 36.3636,
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 40),
                              OutlineButton(
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white,
                                  disabledBorderColor: Colors.white,
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2.5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/googlelogo.png'),
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Log in with Google',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            letterSpacing: 3),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    dynamic result =
                                        await _auth.signInWithGoogle();
                                    result.user != null
                                        ? setState(() => loading = false)
                                        : setState(() => loading = true);
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0))),
                              SizedBox(height: 50),
                              RaisedButton(
                                  padding: EdgeInsets.all(15),
                                  color: Colors.blue[800],
                                  disabledColor: Colors.blue,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/facebooklogo.png'),
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Log in with Facebook',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            letterSpacing: 3),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    /*  setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await AuthService().signInWithFacebook();
                                    result.user != null
                                        ? setState(() => loading = false)
                                        : setState(() => loading = true); */
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0))),
                              SizedBox(height: 50),
                              OutlineButton(
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white,
                                  disabledBorderColor: Colors.white,
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2.5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/anonymous.jpg'),
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Continue Anonymously',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            letterSpacing: 3),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    setState(() => loading = true);
                                    final result =
                                        await _auth.singInAnonymously();

                                    result.user != null
                                        ? setState(() => {loading = false})
                                        : setState(() => loading = true);
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0))),
                              SizedBox(height: 50),
                              Text(
                                  'Device height: ${screenHeight.toStringAsFixed(2)} / Device Width: ${screenWidth.toStringAsFixed(2)}')
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                  child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    Text(
                        'Welcome to the emerald movies app where you can buy tickets, see upcoming movies, buy snacks whilst in the audience and more!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: textSize * 14))
                  ],
                ),
              )),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
