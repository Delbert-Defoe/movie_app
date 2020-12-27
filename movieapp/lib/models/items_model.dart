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
  List<dynamic> selections;
  List<dynamic> sizes;

  Item({this.name, this.prices, this.imgUrl, this.selections, this.sizes});

  Map<String, dynamic> toJson() => {
        'name': name,
        'prices': prices,
        'selections': selections,
        'imgUrl': imgUrl,
        'sizes': sizes
      };

  Map<String, dynamic> toMap() => {
        'name': name,
        'prices': prices.toString(),
        'selections': selections.toString(),
        'imgUrl': imgUrl,
        'sizes': sizes
      };

  Item.fromData(Map<String, dynamic> data)
      : name = data['name'],
        prices = data['prices'],
        selections = data['selections'],
        imgUrl = data['imgUrl'],
        sizes = data['sizes'];
}

class CartItem {
  String name;
  double price;
  String size;
  String imgUrl;

  CartItem({this.name, this.price, this.size, this.imgUrl});
}

class ItemProvider extends ChangeNotifier {
  /*
  List<Item> items = [
    Item(
        name: 'Pop Corn',
        imgUrl: 'popcornpic.png',
        prices: [500, 800, 900, 1000],
        selections: [true, false, false, false],
        sizes: ['S', 'M', 'L', 'XL']),
    Item(
        name: 'Burger',
        imgUrl: 'burger.jpg',
        prices: [500, 800, 900],
        selections: [true, false, false],
        sizes: ['S', 'M', 'L']),
    Item(
        name: 'Hot dog',
        imgUrl: 'hotdog.jpg',
        prices: [500, 800],
        selections: [true, false],
        sizes: ['S', 'M']),
    Item(
        name: 'Sprite',
        imgUrl: 'sprite.jpg',
        prices: [500, 825, 900],
        selections: [true, false, false],
        sizes: ['S', 'M', 'L']),
    Item(
        name: 'Fanta',
        imgUrl: 'fanta.jpg',
        prices: [500, 800, 900],
        selections: [true, false, false],
        sizes: ['S', 'M', 'L'])
  ];
*/

//Lists to be used in the provider
  var items = <Item>[];
  var cart = <CartItem>[];

  //Retrieve Items from the database
  void getItems() async {
    var result = DatabaseService().itemCollection.snapshots().listen((event) {
      event.docs.forEach((element) {
        items.add(Item.fromData(element.data()));
      });
      notifyListeners();
    }).onError(() => print('Error Fetching Items'));
  }

  //Build Selections for the ToggleButtons widget
  Widget buildSelections(String size, Item item) {
    return Text('$size');
  }

  //Add an item to cart
  void addItem(Item item) {
    final cartItem = new CartItem()
      ..price = getPrice(item)
      ..name = item.name
      ..size = getSize(item)
      ..imgUrl = item.imgUrl;

    cart.add(cartItem);

    notifyListeners();
  }

//Remove an item from cart
  void removeItem(int index) {
    cart.removeAt(index);

    notifyListeners();
  }

//Get selected button from the
  void getSelectedButton(int itemIndex, int index) {
    for (int x = 0; x < items[itemIndex].selections.length; x++) {
      items[itemIndex].selections[x] = false;
    }
    items[itemIndex].selections[index] = !items[itemIndex].selections[index];
    notifyListeners();
  }

//Get the selected size for the CartItem object
  String getSize(Item item) {
    for (int x = 0; x < item.selections.length; x++) {
      if (item.selections[x]) {
        return item.prices[x];
      }
    }
  }

//Get the selected Price from the size for the CartItem object
  double getPrice(Item item) {
    for (int index = 0; index < item.selections.length; index++) {
      if (item.selections[index]) {
        return item.prices[index] / 100;
      }
    }
  }

//Calculate the total price of everything in the cart
  double cartTotal() {
    double total = 0;
    for (int index = 0; index < cart.length; index++) {
      total = total + cart[index].price;
    }
    return total;
  }

//Purchasing items alert dialog
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
