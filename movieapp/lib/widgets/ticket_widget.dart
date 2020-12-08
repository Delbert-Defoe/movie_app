import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../models/ticket_model.dart';
import 'package:provider/provider.dart';

class TicketWidget extends StatefulWidget {
  Movie movie;

  TicketWidget({this.movie});

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  String selectedValue = 'Child';
  @override
  Widget build(BuildContext context) {
//Nested in this container is a column, which has a text widget and another container in it. The container has a column with rows in it.
    var ticketProvider = Provider.of<TicketModel>(context);

    return Container(
      height: 570,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Colors.grey[400], Colors.green]),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10, bottom: 0),
              child: Text('Ticket: ',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 500,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFF524E4E),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Screening type row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Screening: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      //Quantity Row
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Quantity: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            IconButton(
                              //will only allow decrementation if is more than 0
                              onPressed: ticketProvider.quantity > 0
                                  ? () => ticketProvider.decrementQuantity()
                                  : null,
                              icon: Icon(
                                Icons.chevron_left,
                              ),
                            ),
                            Text(ticketProvider.quantity.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            IconButton(
                                //will only allow icrementation if quantity is less than 200
                                onPressed: ticketProvider.quantity < 10
                                    ? () => ticketProvider.incrementQuantity()
                                    : null,
                                icon: Icon(
                                  Icons.chevron_right,
                                )),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => ticketProvider.zeroQuantity())
                          ]),
                      //type Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Type: ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          DropdownButton<String>(
                              dropdownColor: Colors.green[500],
                              underline: Container(
                                color: Colors.black,
                                height: 1,
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: Colors.black,
                              ),
                              value: selectedValue,
                              items: ticketProvider.type
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                  // ticketProvider.typeIndicator(selectedValue);
                                });
                              }),
                        ],
                      ),
                      //Date widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Date: ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          IconButton(
                            icon: Icon(Icons.chevron_left),
                            onPressed: ticketProvider.selectedDate > 0
                                ? () => ticketProvider.lastDate(widget.movie)
                                : null,
                          ),
                          Text('Hello World',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: ticketProvider.selectedDate <
                                    widget.movie.timeScreen.length - 1
                                ? () => ticketProvider.changeDate(widget.movie)
                                : null,
                          ),
                        ],
                      ),
                      //time widget
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Time: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            IconButton(
                              icon: Icon(Icons.chevron_left),
                              onPressed: ticketProvider.selectedTime > 0
                                  ? () => ticketProvider.lastTime(widget.movie)
                                  : null,
                            ),
                            Text('LOL',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: ticketProvider.selectedTime <
                                      widget.movie.timeScreen.length - 1
                                  ? () =>
                                      ticketProvider.changeTime(widget.movie)
                                  : null,
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Text('no',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.green[200],
                                      fontWeight: FontWeight.bold)),
                            ),
                            GestureDetector(
                              onTap: ticketProvider.quantity == 0
                                  ? null
                                  : () {
                                      ticketProvider.buyTicket(
                                          widget.movie, context);
                                    },
                              child: Text('Buy',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: ticketProvider.quantity == 0
                                          ? Colors.grey[900]
                                          : Colors.green[200],
                                      fontWeight: FontWeight.bold)),
                            )
                          ])
                    ]),
              ),
            )
          ]),
    );
  }
}
