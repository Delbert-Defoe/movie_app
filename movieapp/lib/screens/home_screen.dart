import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/widgets/this_week_movies_widget.dart';
import 'package:movieapp/widgets/upcoming_movies.dart';
import 'package:movieapp/models/user_model.dart';
import '../models/movies_model.dart';
import '../widgets/schedule_widget.dart';
import '../screens/movie_screen.dart';
import '../widgets/home_drawer_widget.dart';
import '../services/local_database.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[],
      ),
      drawer: HomeDrawer(),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text('This Week',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold)),
          ),
          WeeklyMovies(),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Upcoming Movies',
                  style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          UpcomingMovies(),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
