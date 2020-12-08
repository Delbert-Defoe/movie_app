import 'package:flutter/cupertino.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:provider/provider.dart';
import '../models/movies_model.dart';
import '../services/authentication.dart';
import '../services/database.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/user_model.dart';

class Ticket {
  String movieTitle;
  String userName;
  int price;
  bool confirmed;
  String type;
  int quantity;
  String screening;
  dynamic dateTime;
  bool active;
  String movieImg;
  String date;
  String time;
  String uid;
  String movieID;

  Ticket(
      {this.movieTitle,
      this.userName,
      this.price,
      this.confirmed,
      this.type,
      this.quantity,
      this.screening,
      this.dateTime,
      this.active,
      this.movieImg,
      this.date,
      this.time,
      this.uid,
      this.movieID});

  Map<String, dynamic> toJson() => {
        'movieTitle': movieTitle,
        'userName': userName,
        'price': price,
        'confirmed': confirmed,
        'type': type,
        'quantity': quantity,
        'screening': screening,
        'dateTime': dateTime,
        'active': active,
        'movieImg': movieImg,
        'date': date,
        'time': time,
        'uid': uid
      };

  Ticket.fromData(Map<String, dynamic> data)
      : movieTitle = data['movieTitle'],
        userName = data['userName'],
        price = data['price'],
        confirmed = data['confirmed'],
        type = data['type'],
        quantity = data['quantity'],
        screening = data['screening'],
        dateTime = data['dateTime'],
        active = data['active'],
        movieImg = data['movieImg'],
        date = data['date'],
        time = data['time'],
        uid = data['uid'];
}

class TicketModel extends ChangeNotifier {
  List<Ticket> tickets = [];

  String movieTitle;
  String userName = 'John Doe';
  int price = 0;
  bool confirmed;
  String ticketType;
  int quantity = 1;
  String screening;
  DateTime dateTime;
  bool active;

  var typeIndex = 1;
  List<String> type = ['Child', 'Adult', 'Senior'];

  //these functions changes the quantity
  void incrementQuantity() {
    quantity = quantity + 1;
    notifyListeners();
  }

  void decrementQuantity() {
    quantity = quantity - 1;
    notifyListeners();
  }

  void zeroQuantity() {
    quantity = 0;
    notifyListeners();
  }

  //This function changes type
  void typeIndicator(String type) {
    if (type == 'Child') {
      typeIndex = 0;
    } else if (type == 'Adult') {
      typeIndex = 1;
    } else if (type == 'Senior') {
      typeIndex = 2;
    }
    notifyListeners();
  }

  //This widget warns if a child is selected for an R rated movie
  //Try animated opacity widget
  Widget typeWarning(Movie movie) {
    if (movie.rating == 'R' && typeIndex == 0) {
      return RichText(
          text: TextSpan(
        text: 'This movie is not recommended for children',
        style: TextStyle(fontSize: 15, color: Colors.red),
      ));
    } else if (movie.rating == 'PG' && typeIndex == 0) {
      return RichText(
          text: TextSpan(
        text: 'Adult accompaniment Recommended',
        style: TextStyle(fontSize: 15, color: Colors.red),
      ));
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }

//These functions deal with the diplaying of the Date and time
  int selectedDate = 0;
  int selectedTime = 0;

  String time;
  String date;

  void changeTime(movie) {
    selectedTime = selectedTime + 1;
    notifyListeners();
  }

  void lastTime(movie) {
    selectedTime = selectedTime - 1;
    notifyListeners();
  }

  void changeDate(movie) {
    selectedDate = selectedDate + 1;
    notifyListeners();
  }

  void lastDate(movie) {
    selectedDate = selectedDate - 1;
    notifyListeners();
  }

  Widget showScreeningWidget(Movie movie) {
    return Text(
      movie.timeScreen[selectedDate]['Screening'][selectedTime],
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w800, color: Colors.green[200]),
    );
  }

  Widget showTimeWidget(Movie movie) {
    List<String> times = [];
    String time;
    int x = 0;

    for (int x = 0;
        x < movie.timeScreen[this.selectedTime]['Time'].length;
        x++) {
      time = movie.timeScreen[selectedDate]['Time'][selectedTime]
              .toDate()
              .hour
              .toString() +
          ':' +
          movie.timeScreen[selectedDate]['Time'][selectedTime]
              .toDate()
              .minute
              .toString();

      times.add(time);
    }
    return Text(times[selectedTime],
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800));
  }

  Widget showDateWidget(Movie movie) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    String day =
        days[(movie.timeScreen[selectedDate]['Date'].toDate().weekday) - 1] +
            ' ' +
            movie.timeScreen[selectedDate]['Date'].toDate().day.toString();

    return Text(day,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800));
  }

  Widget priceWidget() {
    if (typeIndex == 0) {
      price = 1500 * quantity;
    } else if (typeIndex == 1) {
      price = 2000 * quantity;
    } else if (typeIndex == 2) {
      price = 1500 * quantity;
    }
    double displayPrice = price / 100;
    return Text('\$ ${displayPrice.toStringAsFixed(2)}',
        style: TextStyle(
            fontSize: 30,
            color: Colors.green[200],
            fontWeight: FontWeight.bold));
  }

  //These functions will create a ticket object
  String getDate(Movie movie) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    String day =
        days[(movie.timeScreen[selectedDate]['Date'].toDate().weekday) - 1] +
            ' ' +
            movie.timeScreen[selectedDate]['Date'].toDate().day.toString();
    print(movie.timeScreen[selectedDate]['Date'].toDate().weekday.toString());
    print(day);
    return day;
  }

  String getTime(Movie movie) {
    List<String> times = [];
    String time;
    int x = 0;

    for (int x = 0;
        x < movie.timeScreen[this.selectedTime]['Time'].length;
        x++) {
      time = movie.timeScreen[selectedDate]['Time'][selectedTime]
              .toDate()
              .hour
              .toString() +
          ':' +
          movie.timeScreen[selectedDate]['Time'][selectedTime]
              .toDate()
              .minute
              .toString();

      times.add(time);
    }
    notifyListeners();
    return times[selectedTime];
  }

  int getPrice() {
    if (typeIndex == 0) {
      price = 1500 * quantity;
    } else if (typeIndex == 1) {
      price = 2000 * quantity;
    } else if (typeIndex == 2) {
      price = 1500 * quantity;
    }
    return price;
  }

  bool isActive(Movie movie) {
    DateTime now = DateTime.now();

    return (movie.timeScreen[selectedDate]['Time'][selectedTime]
        .toDate()
        .isAfter(now));
  }

  String getMonth(Movie movie) {
    String month;
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    month = months[(movie.timeScreen[selectedDate]['Date'].toDate().month) - 1];
    return month;
  }

  Future<void> buyTicket(Movie movie, BuildContext context) async {
    var _auth = AuthService();

    final ticket = new Ticket();

    ticket.uid = await _auth.getCurrentUser();
    ticket.userName = UserModel().user.username;
    ticket.type = type[typeIndex];
    ticket.confirmed = true;
    ticket.dateTime =
        movie.timeScreen[selectedDate]['Time'][selectedTime].toDate();
    ticket.movieTitle = movie.title;
    ticket.price = getPrice();
    ticket.active = isActive(movie);
    ticket.quantity = quantity;
    ticket.screening =
        movie.timeScreen[selectedDate]['Screening'][selectedTime];
    ticket.movieImg = movie.imageUrl;
    ticket.time = getTime(movie);
    ticket.date = getDate(movie) + ' ' + getMonth(movie);

    //Making the Dialoge
    var alertDialog = AlertDialog(
      title: Text('Ticket Purchase'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                TextSpan(text: 'Are you sure you want to purchase '),
                TextSpan(
                    text: '${ticket.quantity} ${ticket.type}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.green[500])),
                TextSpan(text: ' ticket(s) to '),
                TextSpan(
                    text: '${ticket.movieTitle}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.green[500])),
                TextSpan(text: ' for '),
                TextSpan(
                    text: '${ticket.date}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.green[500])),
                TextSpan(text: ' at '),
                TextSpan(
                    text: '${ticket.time}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.green[500])),
                TextSpan(text: '?')
              ])),
          SizedBox(height: 10),
          typeWarning(movie),
        ],
      ),
      actions: [
        FlatButton(
          child: Text('No',
              style: TextStyle(color: Colors.green[600], fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.green[600], fontSize: 18),
          ),
          onPressed: () {
            addTicketToDB(ticket);
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                'Ticket Bought',
                style: TextStyle(fontSize: 20),
              ),
              duration: Duration(seconds: 1),
            ));
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void addTicketToDB(Ticket ticket) {
    var _db = DatabaseService();
    _db.ticketCollection.add(ticket.toJson());
    tickets.add(ticket);
  }
}
