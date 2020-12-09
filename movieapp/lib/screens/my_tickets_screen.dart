import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            'My Tickets',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: StreamBuilder(
            stream: db.getUserTickets(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //if (!snapshot.hasData) noTicketsWidget(context);
              return !snapshot.hasData
                  ? _noTicketsWidget(context)
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(snapshot.data.docs.length.toString());

                        return _ticketList(context,
                            Ticket.fromData(snapshot.data.docs[index].data()));
                      });
            }));
  }

  Widget _ticketList(BuildContext context, Ticket ticket) {
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;

    //Ticket ticket = Ticket.fromData(ticketSnapshot.data());
    return GestureDetector(
      onTap: () => {print(ticket.movieTitle)},
      child: Flexible(
        child: Container(
            margin: EdgeInsets.only(top: 15),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:
                    LinearGradient(colors: [Colors.white, Colors.green[50]])),
            child: Row(
              children: <Widget>[
                Image(
                    fit: BoxFit.cover,
                    width: 100,
                    height: 400,
                    image: AssetImage(ticket.movieImg)),
                FractionallySizedBox(
                  heightFactor: 0.9,
                  //color: Colors.black,
                  // padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.vertical,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Movie: ${ticket.movieTitle}',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Type: ${ticket.type}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Time: ${ticket.time}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Date: ${ticket.date}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Quantity: ${ticket.quantity}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ]),
                )
              ],
            )),
      ),
    );
  }

  Widget _noTicketsWidget(BuildContext context) {
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;
    return Container(
      width: devWidth,
      height: devHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green[500], Colors.black, Colors.black],
              end: Alignment.centerLeft,
              begin: Alignment.bottomRight)),
      child: Center(
          child: Container(
        height: 250,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.movie_filter,
              color: Colors.grey,
              size: 100,
            ),
            Text('No Tickets',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 50,
                    fontWeight: FontWeight.w600))
          ],
        ),
      )),
    );
  }
}
