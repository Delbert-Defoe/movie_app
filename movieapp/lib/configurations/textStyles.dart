import 'dart:ui';

import 'package:flutter/material.dart';

class TextStyles {
  static const pagetitle = TextStyle(
      fontSize: 20,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 1);

  static const prices = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: 2);

  static const itemtitle = TextStyle(
      fontSize: 30,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 0);

  static const label = TextStyle(
      fontSize: 15,
      fontStyle: FontStyle.italic,
      //color: Colors.black,
      letterSpacing: 2);

  static const snackbartitle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Raleway',
      color: Colors.black);
}
