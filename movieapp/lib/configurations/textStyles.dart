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
      fontSize: 25,
      fontWeight: FontWeight.w700,
      fontFamily: 'Raleway',
      color: Color(0xFF00660D),
      letterSpacing: 1);

  static const movieTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Raleway',
    color: Color(0xFFEDF3F6),
  );

  static const boldGreenText = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFF00660D));

  static const movieDescription = TextStyle(
    fontFamily: 'Raleway',
    color: Colors.white,
    fontSize: 20,
    wordSpacing: 1,
  );

  static const moviePageTitle = TextStyle(
      fontFamily: 'Raleway',
      letterSpacing: 4,
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(blurRadius: 10, color: Colors.black, offset: Offset(1, 1))
      ]);

  static const ticketTitle = TextStyle(
      color: Color(0xFF00660D),
      fontSize: 25,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.bold);

  static const ticketWidgetElements = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const drawerElements = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 20);

  static const ticketCardTitle = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 20);
}
