import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/models/items_model.dart';
import '../models/movies_model.dart';
import '../models/ticket_model.dart';
import 'package:provider/provider.dart';

class NewTicketWidget extends StatefulWidget {
  Movie movie;

  NewTicketWidget({@required this.movie});

  @override
  _NewTicketWidgetState createState() => _NewTicketWidgetState();
}

class _NewTicketWidgetState extends State<NewTicketWidget> {
  var selectedValue = 'Adult';
  @override
  Widget build(BuildContext context) {
    var ticketProvider = Provider.of<TicketModel>(context);

    final _mediaQuery = MediaQuery.of(context);
    var _screenHeight = _mediaQuery.size.height;
    var _screenWidth = _mediaQuery.size.width;
    double _cardHeight = 600;
    double _padding;
    double _margin;
    var _borderRadius = Radius.circular(20);

    if (_screenWidth < 400) {
      _padding = 10;
      _margin = 0;
    } else {
      _padding = 20;
      _margin = 20;
    }

    //  if (_screenHeight < 600) {
    //    _cardHeight = _screenHeight;
    //  } else {
    //    _cardHeight = _screenHeight * 0.7;
    //  }

    return Container(
      margin: EdgeInsets.all(_margin),
      height: _cardHeight,
      width: _screenWidth,
      padding: EdgeInsets.only(
          left: _padding, right: _padding, top: 0, bottom: _padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_borderRadius),
          gradient: LinearGradient(colors: [Colors.grey[200], Colors.green])),
      child: Column(children: <Widget>[
        Flexible(
            flex: 1,
            child: Container(
                // padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text('Ticket: ', style: TextStyles.ticketTitle))),
        Flexible(
          flex: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(_borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                  padding: EdgeInsets.all(_padding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.2),
                      borderRadius: BorderRadius.all(_borderRadius)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Screening Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Screening: ',
                            style: TextStyles.ticketWidgetElements,
                          ),
                          ticketProvider.showScreeningWidget(widget.movie)
                        ],
                      ),

                      //Quanity Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity: ',
                            style: TextStyles.ticketWidgetElements,
                          ),
                          IconButton(
                            //will only allow decrementation if is more than 0
                            onPressed: ticketProvider.quantity > 0
                                ? () => ticketProvider.decrementQuantity()
                                : null,
                            icon: Icon(
                              Icons.chevron_left,
                            ),
                          ),
                          Text(
                            '${ticketProvider.quantity}',
                            style: TextStyles.ticketWidgetElements,
                          ),
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
                        ],
                      ),

                      //Type Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Type: ',
                              style: TextStyles.ticketWidgetElements),
                          DropdownButton<String>(
                              dropdownColor: Colors.green[500].withOpacity(0.8),
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
                                  ticketProvider.typeIndicator(selectedValue);
                                });
                              }),
                        ],
                      ),
                      ticketProvider.typeWarning(widget.movie),

                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Text('Date: ',
                              style: TextStyles.ticketWidgetElements),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  onPressed: ticketProvider.selectedDate > 0
                                      ? () =>
                                          ticketProvider.lastDate(widget.movie)
                                      : null,
                                ),
                                ticketProvider.showDateWidget(widget.movie),
                                IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  onPressed: ticketProvider.selectedDate <
                                          widget.movie.timeScreen.length - 1
                                      ? () => ticketProvider
                                          .changeDate(widget.movie)
                                      : null,
                                ),
                              ])
                        ],
                      ),

                      //time widget
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Time: ',
                                style: TextStyles.ticketWidgetElements),
                            IconButton(
                              icon: Icon(Icons.chevron_left),
                              onPressed: ticketProvider.selectedTime > 0
                                  ? () => ticketProvider.lastTime(widget.movie)
                                  : null,
                            ),
                            ticketProvider.showTimeWidget(
                                widget.movie), //Actual Time widget
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
                            ticketProvider.priceWidget(),
                            FlatButton(
                              child: Text('Buy',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 30,
                                      color: ticketProvider.quantity == 0
                                          ? Colors.grey[900].withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold)),
                              onPressed: ticketProvider.quantity == 0
                                  ? null
                                  : () {
                                      ticketProvider.buyTicket(
                                          widget.movie, context);
                                    },
                            )
                          ])
                    ],
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}
