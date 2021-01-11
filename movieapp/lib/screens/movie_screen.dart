import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/movies_model.dart';
import 'package:movieapp/services/database.dart';
import '../models/ticket_model.dart';
import '../widgets/ticket_widget.dart';
import '../widgets/test_ticket_widget.dart';
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
    final devWidth = MediaQuery.of(context).size.width;
    final devHeight = MediaQuery.of(context).size.height;
    final imgheight = devHeight * 0.40;
    final double titleSize = 30;

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
                size: titleSize,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${widget.movie.title}',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        letterSpacing: 4,
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                              blurRadius: 10,
                              color: Colors.black,
                              offset: Offset(1, 1))
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                preferredSize: Size(60, 60)),
            pinned: true,
            floating: true,
            backgroundColor: Colors.black,
            flexibleSpace: Stack(
              children: [
                FutureBuilder(
                    future: DatabaseService().getPicture(widget.movie.imageUrl),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          height: imgheight,
                          width: devWidth,
                          child: SpinKitWave(
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      return Container(
                          child: Stack(children: <Widget>[
                        Hero(
                          tag: widget.movie.imageUrl,
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            imageUrl: snapshot.data,
                            height: imgheight,
                            width: devWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]));
                    }),
                /*  Positioned(
                    left: 20,
                    bottom: 10,
                    child: Text(
                      '${widget.movie.title}',
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )),*/
              ],
            ),
            expandedHeight: imgheight,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Text(
                  widget.movie.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 20,
                      wordSpacing: 1),
                ),
              ),
              widget.movie.onscreen
                  ? TicketWidgetTest(
                      movie: widget.movie,
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Coming Soon!',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
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
