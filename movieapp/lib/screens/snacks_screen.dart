import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
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
  List<Color> gradient = [
    Colors.green[800],
    Colors.green[300],
    Colors.grey[200]
  ];

  int gradientNumber = 0;

  void changeContainerColor() {
    if (gradientNumber == 0) {
      gradientNumber = 1;
      setState(() {
        gradient = [Colors.green[200], Colors.green[300], Colors.grey[400]];
      });
    } else if (gradientNumber == 1) {
      gradientNumber = 0;
      setState(() {
        gradient = [Colors.green[500], Colors.green[300], Colors.grey[200]];
      });
    }
  }

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
          title: Text('Snacks', style: TextStyles.pagetitle),
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
                    color: Colors.grey[800],
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
/*
                  return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      padding: EdgeInsets.all(0),
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradient),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(children: <Widget>[
                        FutureBuilder(
                            future:
                                DatabaseService().getItemPicture(item.imgUrl),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                );

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: snapshot.data,
                                  height: 200,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                item.name,
                                style: TextStyles.itemtitle,
                              ),
                              Text(
                                '\$${itemProvider.getPrice(item).toStringAsFixed(2)}',
                                style: TextStyles.prices,
                              ),
                              InkWell(
                                child: FlatButton.icon(
                                    icon: Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                    label: Text('Add'),
                                    onPressed: () {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        content: Text(
                                          '${item.name} Added To Cart!',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ));

                                      itemProvider.addItem(item);
                                    }),
                              ),
                              ToggleButtons(
                                children: [
                                  ...item.sizes.map((size) => itemProvider
                                      .buildSelections(size.toString()))
                                ],
                                onPressed: (int index) {
                                  itemProvider.getSelectedButton(
                                      itemIndex, index);
                                },
                                //the index used below is the index provided by the listview builder
                                isSelected: item.selections,
                                fillColor: Colors.green,
                                selectedColor: Colors.white,
                                borderColor: Colors.grey[500],
                              )
                            ]),
                      ]));
                */
                }));
  }
}

class _CartIcon extends StatelessWidget {
  double cartIndicatorSize = 10;

  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);

    return FlatButton(
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
            size: 35,
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
    );
  }
}
