import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/models/movies_model.dart';
import 'package:movieapp/services/database.dart';
import '../models/ticket_model.dart';
import '../widgets/ticket_widget.dart';
import '../widgets/ticket_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieScreen extends StatefulWidget {
  Movie movie;
  MovieScreen({this.movie});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    final _devWidth = MediaQuery.of(context).size.width;
    final _devHeight = MediaQuery.of(context).size.height;
    final _imgheight = _devHeight * 0.40;
    final double _titleSize = 30;
    final _prefappbarheight = _devHeight / 10;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: _titleSize,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${widget.movie.title}',
                    style: TextStyles.moviePageTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                preferredSize: Size(_prefappbarheight, _prefappbarheight)),
            pinned: true,
            floating: false,
            backgroundColor: Colors.black,
            flexibleSpace: Stack(
              children: [
                FutureBuilder(
                    future: DatabaseService().getPicture(widget.movie.imageUrl),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return MovieLoadingWidget(
                            imgHeight: _imgheight, devwidth: _devWidth);
                      else
                        return Container(
                          child: Hero(
                            tag: widget.movie.imageUrl,
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              imageUrl: snapshot.data,
                              height: _imgheight,
                              width: _devWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                    }),
              ],
            ),
            expandedHeight: _imgheight,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Text(
                  widget.movie.description,
                  textAlign: TextAlign.left,
                  style: TextStyles.movieDescription,
                ),
              ),
              widget.movie.onscreen
                  ? NewTicketWidget(
                      movie: widget.movie,
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Coming Soon!',
                            style: TextStyles.boldGreenText),
                      ),
                    )
            ]),
          )
        ]),
      ),
    );
  }
}

//Add a tab bar that contains the dates that the movies are streaming so it displays the respective ticket

class MovieLoadingWidget extends StatelessWidget {
  double imgHeight;
  double devwidth;

  MovieLoadingWidget({@required this.imgHeight, @required this.devwidth});
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
            alignment: Alignment.center,
            width: devwidth,
            height: imgHeight,
            decoration: BoxDecoration(
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
  }
}
