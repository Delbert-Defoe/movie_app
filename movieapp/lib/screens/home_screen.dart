import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/widgets/this_week_movies_widget.dart';
import 'package:movieapp/widgets/upcoming_movies.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies_model.dart';
import '../screens/movie_screen.dart';
import '../widgets/home_drawer_widget.dart';
import '../services/local_database.dart';
import '../services/database.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _screenheight = mediaQuery.size.height;
    final _screenwidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        title: Text(
          'Emerald Movies',
          style: TextStyles.pagetitle,
        ),
        actions: <Widget>[],
      ),
      drawer: HomeDrawer(),
      body: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        WeeklyMovies(),
        UpcomingMovies(),
      ]),
    );
  }
}
