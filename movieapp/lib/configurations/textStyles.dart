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
      //color: Colors.black,
      color: Color(0xFF00660D),
      letterSpacing: 2);

  static const itemtitle = TextStyle(
      fontSize: 30,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 0);

  static const itemtitlewhite = TextStyle(
      fontSize: 30,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: 0);

  static const label = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 15,
      fontStyle: FontStyle.italic,
      //color: Colors.black,
      letterSpacing: 2);

  static const labelwhite = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 15,
      fontStyle: FontStyle.italic,
      color: Colors.white,
      letterSpacing: 2);

  static const snackbartitle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Raleway',
      color: Colors.black);

  static const carouseltitle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontFamily: 'Raleway',
      color: Colors.white);
}
