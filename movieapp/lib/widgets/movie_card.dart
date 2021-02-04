import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/models/movies_model.dart';
import 'package:movieapp/services/database.dart';

class MovieCard extends StatefulWidget {
  DocumentSnapshot movieSnapshot;
  MovieCard({@required this.movieSnapshot});

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  final db = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    final mediaInfo = MediaQuery.of(context);
    final double _borderRadius = 20;
    var movie = Movie.fromData(widget.movieSnapshot.data());

    return LayoutBuilder(builder: (context, constraints) {
      var _cardHeight = constraints.maxHeight;
      var _cardwidth = mediaInfo.size.width / 2;

      return FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/movie_screen', arguments: movie);
          },
          child: FutureBuilder(
            future: db.getPicture(movie.imageUrl),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData)
                return LoadingWidget();
              else
                return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      height: _cardHeight,
                      width: _cardwidth,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_borderRadius))),
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.clip,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            child: Hero(
                              tag: movie.imageUrl,
                              child: CachedNetworkImage(
                                height: _cardHeight,
                                width: _cardwidth,
                                fit: BoxFit.cover,
                                imageUrl: snapshot.data,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                                height: _cardHeight * 0.15,
                                width: _cardwidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(_borderRadius)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.black.withOpacity(0.4),
                                          Colors.black.withOpacity(0.8),
                                          Colors.black.withOpacity(0.4)
                                        ])),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    movie.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.movieTitle,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    builder: (context, _tween, child) {
                      return Opacity(opacity: _tween, child: child);
                    });
            },
          ));
    });
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double _borderRadius = 20;

    return LayoutBuilder(builder: (context, constraints) {
      var _cardHeight = constraints.maxHeight;
      var _cardwidth = mediaQuery.size.width / 2;
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
              alignment: Alignment.center,
              width: _cardwidth,
              height: _cardHeight,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade200.withOpacity(0.2),
                        // Colors.grey.shade100.withOpacity(0.4),
                        Colors.grey.shade200.withOpacity(0.2)
                      ])),
              child: Center(
                child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor),
              )),
        ),
      );
    });
  }
}
