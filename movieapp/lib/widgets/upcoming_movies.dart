import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/models/ticket_model.dart';
import 'package:movieapp/widgets/movie_card.dart';
import 'package:movieapp/widgets/scheduleWidget.dart';
import '../models/movies_model.dart';
import '../screens/movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/services/database.dart';
import 'package:movieapp/animations/pageRouteScaleAnimation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UpcomingMovies extends StatefulWidget {
  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  //List<Movie> ourmovies;
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
            flex: 3,
            child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeIn,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upcoming Movies', style: TextStyles.carouseltitle),
                    ],
                  ),
                ),
                builder: (context, _tween, child) {
                  return Transform.translate(
                    offset: Offset(-100 + _tween * 100, 0),
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
                stream: db.getMovies(context, false),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return SpinKitWave(
                        color: Theme.of(context).primaryColor,
                        size: MediaQuery.of(context).size.width / 5);
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
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

  //Stream<DocumentSnapshot>
}
