import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class Item {
  String name;
  String imgUrl;
  List<dynamic> prices;
  double quantity;
  List<dynamic> selections;
  List<dynamic> get sizes {
    for (int i = 0; i < prices.length; i++) {
      if (i == 0)
        selections.add('S');
      else if (i == 1)
        selections.add('M');
      else if (i == 2)
        selections.add('L');
      else if (i == 3) selections.add('XL');

      return selections;
    }
  }

  Item(
      {this.name,
      this.prices,
      this.imgUrl,
      this.quantity = 0.0,
      this.selections});

  Map<String, dynamic> toJson() => {
        'name': name,
        'prices': prices,
        'quantity': 0,
        'selections': selections,
        'imgUrl': imgUrl
      };

  Map<String, dynamic> toMap() => {
        'name': name,
        'prices': prices.toString(),
        'quantity': 0,
        'selections': selections.toString(),
        'imgUrl': imgUrl,
      };

  Item.fromData(Map<String, dynamic> data)
      : name = data['name'],
        prices = data['prices'],
        quantity = data['quantity'],
        selections = data['selections'],
        imgUrl = data['imgUrl'];
}

class CartItem {
  String name;
  double price;
  String size;
  String imgUrl;

  CartItem({this.name, this.price, this.size, this.imgUrl});
}

class ItemProvider extends ChangeNotifier {
  /* List<Item> items = [
    Item(
      
      name: 'Pop Corn',
      imgUrl: 'assets/images/popcornpic.png',
      prices: [500, 800, 900, 1000],
      price: 0,
      selections: [true, false, false, false],
    ),
    Item(
      name: 'Burger',
      imgUrl: 'assets/images/burger.jpg',
      prices: [500, 800, 900],
      price: 0,
      selections: [true, false, false],
    ),
    Item(
      name: 'Hot dog',
      imgUrl: 'assets/images/hotdog.jpg',
      prices: [500, 800],
      price: 0,
      selections: [true, false],
    ),
    Item(
      name: 'Sprite',
      imgUrl: 'assets/images/sprite.jpg',
      prices: [500, 825, 900],
      price: 0,
      selections: [true, false, false],
    ),
    Item(
      name: 'Fanta',
      imgUrl: 'assets/images/fanta.jpg',
      prices: [500, 800, 900],
      price: 0,
      selections: [true, false, false],
    )
  ];
  */

  List items = [];

  //void getItems

  Widget buildSelections(String size, Item item) {
    return Text('$size');
  }

  List<CartItem> cart = [];

  void addItem(Item item) {
    final cartItem = new CartItem();

    cartItem.price = getPrice(item);
    cartItem.name = item.name;
    cartItem.size = getSize(item);
    cartItem.imgUrl = item.imgUrl;

    cart.add(cartItem);

    notifyListeners();
  }

  void removeItem(int index) {
    cart.removeAt(index);

    notifyListeners();
  }

  void getSelectedButton(Item item, int index) {
    for (int x = 0; x < item.selections.length; x++) {
      item.selections[x] = false;
    }
    item.selections[index] = !item.selections[index];
    notifyListeners();
  }

  String getSize(Item item) {
    if (item.selections[0]) {
      return 'Small';
    } else if (item.selections[1]) {
      return 'Medium';
    } else if (item.selections[2]) {
      return 'Large';
    } else if (item.selections[3]) {
      return 'Extra Large';
    }
  }

  double getPrice(Item item) {
    int price;
    for (int index = 0; index < item.selections.length; index++) {
      if (item.selections[index] == true) {
        price = item.prices[index];
      }
    }
    return price / 100;
  }

  double cartTotal() {
    double total = 0;
    for (int index = 0; index < cart.length; index++) {
      total = total + cart[index].price;
    }
    return total;
  }

  void purchaseItems(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Item Purcahse'),
      content: RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
            TextSpan(text: 'Are you sure that you would like to purchase '),
            TextSpan(
                text: '${cart.length}',
                style: TextStyle(
                    color: Colors.green[600], fontWeight: FontWeight.w600)),
            TextSpan(text: ' item(s) for '),
            TextSpan(
                text: '\$${cartTotal().toStringAsFixed(2)}',
                style: TextStyle(
                    color: Colors.green[600], fontWeight: FontWeight.w600)),
            TextSpan(text: '?')
          ])),
      actions: [
        FlatButton(
          child: Text(
            'No',
            style: TextStyle(color: Colors.green[600]),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.green[600]),
          ),
          onPressed: () {
            print('i ran');
            //This gets your application id for the Square API
            InAppPayments.setSquareApplicationId(
                'sandbox-sq0idb-JLrh13zUisgJlQ-zS6ks5Q');
            /* This next function starts the card entry process and can have two occurences
            if the card is entered successfully it runs the function assigned to 'onCardNonceRequestSuccess'
            if the card is not entered successfully it runs 'onCardEntryCancel*/
            InAppPayments.startCardEntryFlow(
                onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
                onCardEntryCancel: _onCardEntryCancel,
                collectPostalCode: false);
          },
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

//successful card entry
  _cardEntryComplete() {
    print('Complete');
  }

  _onCardNonceRequestSuccess(CardDetails result) {
    print(result.nonce);

    InAppPayments.completeCardEntry(
      onCardEntryComplete: _cardEntryComplete,
    );
  }

  _onCardEntryCancel() {
    print('Cancelled');
  }
}
