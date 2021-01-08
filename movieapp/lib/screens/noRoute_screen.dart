import 'package:flutter/material.dart';

class NoRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
        'No Such Route Found',
        style: TextStyle(color: Colors.white, fontFamily: 'Raleway'),
      )),
    );
  }
}
