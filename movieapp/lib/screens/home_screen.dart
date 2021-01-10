import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/configurations/textStyles.dart';
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
          style: TextStyles.pagetitle,
        ),
        actions: <Widget>[],
      ),
      drawer: HomeDrawer(),
      body: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        Container(
          //color: Colors.red,
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Container(
                //color: Colors.blue,
                child: TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.easeIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('This Week', style: TextStyles.carouseltitle),
                        FlatButton(
                          onPressed: () => _showBottomModalSheet(context),
                          child: Text(
                            'See Schedule',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway',
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    builder: (context, _tween, child) {
                      return Transform.translate(
                        offset: Offset(100 - _tween * 100, 0),
                        child: Opacity(
                          opacity: _tween,
                          child: child,
                        ),
                      );
                    }),
              ),
            ),
            WeeklyMovies(),
            SizedBox(
              height: 15,
            ),
          ]),
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
                  style: TextStyles.carouseltitle,
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
