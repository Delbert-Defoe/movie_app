import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
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
  final List<Color> _gradient = [
    Colors.green[800],
    Colors.green[300],
    Colors.grey[200]
  ];

  final styles = TextStyles();

  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
    var _cardheight;
    var _cardwidth;

    if (_screenHeight < 450) {
      _cardheight = _screenHeight / 2;
    } else if (_screenHeight < 600) {
      _cardheight = _screenHeight / 2.8;
    } else if (_screenHeight < 1250) {
      _cardheight = _screenHeight / 4;
    }
    _cardwidth = _screenWidth;
    var _togglebuttonSize = _cardheight / 4.5;

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
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200].withOpacity(0.5),
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
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                          ),
                          flex: 4,
                        )
                      ]),
                    ),
                  ),
                ),
              ))
            : ListView.builder(
                padding: EdgeInsets.all(0),
                physics: BouncingScrollPhysics(),
                itemCount: itemProvider.items.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  Item item = itemProvider.items[itemIndex];
                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.bounceIn,
                    child: Container(
                      height: _cardheight,
                      width: _cardwidth,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: _gradient),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(children: [
                        Flexible(
                          flex: 1,
                          child: FutureBuilder(
                              future:
                                  DatabaseService().getItemPicture(item.imgUrl),
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  );

                                return LayoutBuilder(
                                    builder: (context, constraints) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Opacity(
                                        opacity: 0.2,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/movie_snacks.jpg'),
                                            height: constraints.maxHeight,
                                            width: constraints.maxWidth,
                                            fit: BoxFit.cover),
                                      ),
                                      imageUrl: snapshot.data,
                                      height: constraints.maxHeight,
                                      width: constraints.maxWidth,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                });
                              }),
                        ),
                        Flexible(
                            flex: 2,
                            child: Center(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('${item.name}',
                                        style: TextStyles.itemtitle),
                                    Text(
                                      '\$${itemProvider.getPrice(item).toStringAsFixed(2)}',
                                      style: TextStyles.prices,
                                    ),
                                    InkWell(
                                      child: FlatButton.icon(
                                          icon: Icon(Icons.add),
                                          label: Text('Add To Cart'),
                                          onPressed: () {
                                            itemProvider.addItem(item);
                                            _itemSnackbar(item, context);
                                          }),
                                    ),
                                    ToggleButtons(
                                      constraints: BoxConstraints.expand(
                                          width: _togglebuttonSize,
                                          height: _togglebuttonSize),
                                      children: [
                                        ...item.sizes
                                            .map(itemProvider.buildSelections)
                                      ],
                                      onPressed: (int index) {
                                        itemProvider.getSelectedButton(
                                            itemIndex, index);
                                      },
                                      //the index used below is the index provided by the listview builder
                                      isSelected: itemProvider
                                          .items[itemIndex].selections,
                                      fillColor: Colors.green,
                                      selectedColor: Colors.white,
                                      borderColor: Colors.grey[500],
                                    )
                                  ]),
                            ))
                      ]),
                    ),
                    builder: (context, _tween, _child) {
                      return Transform.scale(
                          scale: _tween,
                          child: Opacity(
                            opacity: _tween,
                            child: _child,
                          ));
                    },
                  );
                }));
  }
}

class _CartIcon extends StatelessWidget {
  double cartIndicatorSize = 15;

  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);

    return InkWell(
      child: FlatButton(
        color: Colors.transparent,
        onPressed: () {
          Navigator.pushNamed(context, '/cart_screen');
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
                      alignment: Alignment.center,
                      child: Text(
                        '${itemProvider.cart.length}',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ))
          ],
        ),
      ),
    );
  }
}

void _itemSnackbar(Item item, BuildContext context) {
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
        height: kBottomNavigationBarHeight * 0.5,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          ' + ${item.name} Added To Cart !  🛒',
          style: TextStyles.snackbartitle,
        ),
      ),
      duration: Duration(seconds: 2),
    ));
}
