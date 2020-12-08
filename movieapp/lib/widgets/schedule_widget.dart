import 'package:flutter/material.dart';
import '../models/movies_model.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF727272),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text('Schedule: ',
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5)),
            ),
            Container(
                height: 500,
                width: 1000,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {}))
          ]),
    );
  }
}

List<Map> scheduledays = [
  {
    'Day': 'Sunday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  },
  {
    'Day': 'Monday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  },
  {
    'Day': 'Tuesday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  },
  {
    'Day': 'Wednesday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  },
  {
    'Day': 'Thursday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  },
  {
    'Day': 'Friday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  },
  {
    'Day': 'Saturday',
    '9:30': 'some movie',
    '10:30': 'Some Movie',
    '11:30': 'Some Movie'
  }
];

//this function is supposed to receive all the dates and place them accordingly
