import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/models/items_model.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '🛒 Cart',
          style: TextStyles.pagetitle,
        ),
      ),
      body: itemProvider.cart.length < 1
          ? Container(
              width: devWidth,
              height: devHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.green[800], Colors.black, Colors.black],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cart Empty',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Raleway'),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(15),
                      color: Colors.green[300],
                      child: Text(
                        'Buy Food!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ))
          : ListView.builder(
              itemCount: itemProvider.cart.length,
              itemBuilder: (BuildContext context, int index) {
                var item = itemProvider.cart[index];
                return Column(
                  children: [
                    FutureBuilder(
                        future: DatabaseService().getItemPicture(item.imgUrl),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                imageUrl: snapshot.data,
                                height: 200,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(item.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600)),
                            subtitle: Text(
                              '${item.size}: \$${item.price.toStringAsFixed(2)}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              onPressed: () {
                                itemProvider.removeItem(index);
                                // _removeItem(index, context);
                              },
                            ),
                          );
                        }),
                    Divider(
                      color: Colors.white,
                      indent: devWidth * 0.12152777777777777440200617283951,
                      endIndent: devWidth * 0.12152777777777777440200617283951,
                      height: devHeight * 0.02,
                      thickness: 0.1,
                    )
                  ],
                );
              }),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    var height = kBottomNavigationBarHeight * 1.1;
    return Container(
        color: Theme.of(context).primaryColor,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total : \$ ${itemProvider.cartTotal().toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 2),
            ),
            RaisedButton(
              elevation: 6,
              child: Text(
                'Purchase',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: itemProvider.cartTotal() == 0
                        ? Colors.black
                        : Colors.white),
              ),
              onPressed: () {
                itemProvider.purchaseItems(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.green[500],
              padding: EdgeInsets.all(15),
            )
          ],
        ));
  }
}
