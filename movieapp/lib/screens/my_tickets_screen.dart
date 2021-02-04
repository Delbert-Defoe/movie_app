import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/services/database.dart';
import 'package:movieapp/services/local_database.dart';
import 'package:provider/provider.dart';
import '../models/ticket_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/local_database.dart';

class MyTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    // final ldb = LocalDatabase.instance;
    var ticketProvider = Provider.of<TicketModel>(context);
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            '🎫 My Tickets',
            style: TextStyles.pagetitle,
          ),
        ),
        body: StreamBuilder(
            stream: db.getUserTickets(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? _noTicketsWidget(context)
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TicketCard(
                            ticket: Ticket.fromData(
                                snapshot.data.docs[index].data()));
                        // return _ticketList(context,
                        //     Ticket.fromData(snapshot.data.docs[index].data()));
                      });
            }));
  }

  Widget _noTicketsWidget(BuildContext context) {
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;
    return Container(
      width: devWidth,
      height: devHeight,
      child: Center(
          child: Container(
        margin: EdgeInsets.all(20),
        height: devWidth / 1.5,
        width: devWidth,
        decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.movie_filter,
              color: Colors.grey,
              size: devWidth / 3,
            ),
            Text('No Tickets',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey,
                    fontSize: 50,
                    fontWeight: FontWeight.w600))
          ],
        ),
      )),
    );
  }
}

class TicketCard extends StatelessWidget {
  Ticket ticket;

  TicketCard({@required this.ticket});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    final _mediaQuery = MediaQuery.of(context);
    var _orientaiton = _mediaQuery.orientation;
    var _screenHeight = _mediaQuery.size.height;
    var _screenWidth = _mediaQuery.size.width;
    var _cardHeight;
    var _cardWidth;
    double _padding = 10.0;
    var _borderRadius = Radius.circular(20);

    if (_screenHeight < 600) {
      _cardHeight = _screenHeight / 3;
    } else {
      _cardHeight = _screenHeight / 4;
    }
    _cardWidth = _screenWidth;

    return Container(
      height: _cardHeight,
      width: _cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(_borderRadius),
        color: Colors.grey.shade200.withOpacity(0.4),
      ),
      margin: EdgeInsets.symmetric(vertical: _padding),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        children: <Widget>[
          FutureBuilder<String>(
              future: db.getPicture(ticket.movieImg),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  );
                else
                  return ClipRRect(
                    borderRadius: BorderRadius.all(_borderRadius),
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          height: 0,
                          width: 0,
                        );
                      },
                      imageUrl: snapshot.data,
                      height: _cardHeight,
                      width: _cardWidth,
                      fit: BoxFit.cover,
                    ),
                  );
              }),
          Positioned(
            bottom: 0,
            child: Container(
              height: _cardHeight / 2,
              width: _cardWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.center,
                      begin: Alignment.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.4),
                  ])),
              child: Column(children: <Widget>[
                Text(
                  '${ticket.movieTitle}',
                  style: TextStyles.ticketCardTitle,
                ),
                Text(
                  '${ticket.date}',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.green[400]),
                ),
                Text(
                  '${ticket.type} x ${ticket.quantity}',
                  style: TextStyles.ticketCardTitle,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
