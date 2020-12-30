import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/widgets/this_week_movies_widget.dart';
import 'package:movieapp/widgets/upcoming_movies.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies_model.dart';
import '../widgets/schedule_widget.dart';
import '../screens/movie_screen.dart';
import '../widgets/home_drawer_widget.dart';
import '../services/local_database.dart';
import '../services/database.dart';

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
            padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.easeIn,
                    child: Text('This Week',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold)),
                    builder: (context, _tween, child) {
                      return Transform.translate(
                        offset: Offset(100 - _tween * 100, 0),
                        child: Opacity(
                          opacity: _tween,
                          child: child,
                        ),
                      );
                    }),
                FlatButton(
                  onPressed: () => _showBottomModalSheet(context),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'See Schedule',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
                TweenAnimationBuilder(
                  duration: Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0, end: 1),
                  child: Text(
                    'Upcoming Movies',
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  builder: (context, _tween, child) {
                    return Transform.translate(
                      offset: Offset(-100 + _tween * 100, 0),
                      child: Opacity(opacity: _tween, child: child),
                    );
                  },
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

  void _showBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10, bottom: 5, left: 10),
                      constraints: BoxConstraints.expand(),
                      // color: Colors.black,
                      child: Text('This week\'s Schedule:',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: FutureBuilder(
                        future: DatabaseService().getSchedule(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          else
                            return InteractiveViewer(
                                child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              imageUrl: snapshot.data,
                            ));
                        }),
                  ),
                ],
              ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }
}
