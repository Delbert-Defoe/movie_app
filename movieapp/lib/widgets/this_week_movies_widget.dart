import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/widgets/scheduleWidget.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:movieapp/models/ticket_model.dart';
import 'package:movieapp/widgets/movie_card.dart';
import '../models/movies_model.dart';
import '../screens/movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/services/database.dart';
import 'package:movieapp/animations/pageRouteScaleAnimation.dart';
import 'package:movieapp/configurations/textStyles.dart';

class WeeklyMovies extends StatefulWidget {
  @override
  _WeeklyMoviesState createState() => _WeeklyMoviesState();
}

class _WeeklyMoviesState extends State<WeeklyMovies> {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    var _carouselHeight = _mediaQuery.size.height / 2;

    if (_mediaQuery.size.height < 450) {
      _carouselHeight = _mediaQuery.size.height;
    }

    return Container(
        height: _carouselHeight,
        child: Column(children: [
          Flexible(
            flex: 2,
            child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeIn,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text('This Week', style: TextStyles.carouseltitle),
                      FlatButton(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        onPressed: () => showBottomModalSheet(context),
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
          Flexible(
            flex: 8,
            child: StreamBuilder(
                stream: db.getMovies(context, true),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return SpinKitWave(
                        color: Theme.of(context).primaryColor,
                        size: MediaQuery.of(context).size.width / 5);
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      //padding: EdgeInsets.all(5.0),
                      scrollDirection: Axis.horizontal,
                      //controller: _scrollController,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          // buildMovieWidget(context, snapshot.data.docs[index]))
                          MovieCard(movieSnapshot: snapshot.data.docs[index]));
                }),
          ),
        ]));
  }
}
