import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/ticket_model.dart';
import '../models/movies_model.dart';
import '../screens/movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/services/database.dart';
import 'package:movieapp/animations/pageRouteScaleAnimation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class WeeklyMovies extends StatefulWidget {
  @override
  _WeeklyMoviesState createState() => _WeeklyMoviesState();
}

class _WeeklyMoviesState extends State<WeeklyMovies> {
  //List<Movie> ourmovies;
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var ticketProvider = Provider.of<TicketModel>(context);
    return Container(
      height: 300,
      //color: Colors.red,
      child: StreamBuilder(
          stream: db.getMovies(context, true),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return SpinKitWave(
                  color: Theme.of(context).primaryColor,
                  size: MediaQuery.of(context).size.width / 5);
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                //padding: EdgeInsets.all(5.0),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildMovieWidget(context, snapshot.data.docs[index]));
          }),
    );
  }

  Widget buildMovieWidget(
      BuildContext context, DocumentSnapshot movieSnapshot) {
    Movie movie = Movie.fromData(movieSnapshot.data());
    return GestureDetector(
      onTap: () {
        //  Navigator.push(
        //      context,
        //      ScaleAnimation(
        //          widget: MovieScreen(
        //        movie: movie,
        //      )));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieScreen(
                      movie: movie,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
        width: 220,
        child: Stack(children: <Widget>[
          FutureBuilder(
              future: DatabaseService().getPicture(movie.imageUrl),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData)
                  return SpinKitWave(
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  );
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: movie.imageUrl,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: snapshot.data,
                      height: 300,
                      width: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
          Positioned(
              left: 5.0,
              bottom: 20.0,
              child: Text(
                movie.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ))
        ]),
      ),
    );
  }

  //Stream<DocumentSnapshot>
}
