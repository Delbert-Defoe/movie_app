import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:movieapp/screens/testCartScreen.dart';
import 'package:movieapp/services/database.dart';
import 'package:movieapp/widgets/item_card.dart';
import 'package:path/path.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../models/items_model.dart';
import '../configurations/textStyles.dart';

class SnacksScreen extends StatefulWidget {
  @override
  _SnacksScreenState createState() => _SnacksScreenState();
}

class _SnacksScreenState extends State<SnacksScreen> {
  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    var styles = TextStyles();

    if (itemProvider.items.isEmpty) {
      itemProvider.getItems();
    } // If the item list is empty, it will populate the item
    /*
    * This function will most likely be deprecated once items are moved to the local database
    */

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('🍿 Snacks', style: TextStyles.pagetitle),
          actions: <Widget>[_CartIcon()],
        ),
        body: itemProvider.items.isEmpty
            ? Center(
                child: FractionallySizedBox(
                heightFactor: 0.4,
                widthFactor: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[700],
                  ),
                  child: Column(children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Fetching Items....',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      flex: 1,
                    ),
                    Flexible(
                      child: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor),
                      ),
                      flex: 4,
                    )
                  ]),
                ),
              ))
            : ListView.builder(
                padding: EdgeInsets.all(0),
                physics: BouncingScrollPhysics(),
                itemCount: itemProvider.items.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  Item item = itemProvider.items[itemIndex];
                  return ItemCard(
                    item: item,
                    itemIndex: itemIndex,
                  );
                }));
  }
}

class _CartIcon extends StatelessWidget {
  double cartIndicatorSize = 10;

  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);

    return InkWell(
      child: FlatButton(
        color: Colors.transparent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: Stack(
          fit: StackFit.loose,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.black,
            ),
            itemProvider.cart.isEmpty
                ? Container(
                    height: 0,
                    width: 0,
                  )
                : Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: cartIndicatorSize,
                      width: cartIndicatorSize,
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ))
          ],
        ),
      ),
    );
  }
}
