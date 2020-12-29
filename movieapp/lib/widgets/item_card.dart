import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:movieapp/models/items_model.dart';
import 'package:movieapp/services/database.dart';
import 'package:movieapp/configurations/textStyles.dart';

class ItemCard extends StatelessWidget {
  Item item;
  int itemIndex;

  ItemCard({@required this.item, @required itemIndex});

  final List<Color> _gradient = [
    Colors.green[800],
    Colors.green[300],
    Colors.grey[200]
  ];

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height / 4;
    final _width = MediaQuery.of(context).size.width;

    final itemProvider = Provider.of<ItemProvider>(context);

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.bounceIn,
      child: Container(
        height: _height,
        width: _width,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: _gradient),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(children: [
          Flexible(
            flex: 1,
            child: FutureBuilder(
                future: DatabaseService().getItemPicture(item.imgUrl),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    );

                  return LayoutBuilder(builder: (context, constraints) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: snapshot.data,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('${item.name}', style: TextStyles.itemtitle),
                      Text(
                        '\$${itemProvider.getPrice(item).toStringAsFixed(2)}',
                        style: TextStyles.prices,
                      ),
                      InkWell(
                        child: FlatButton.icon(
                            icon: Icon(Icons.add),
                            label: Text('Add To Cart'),
                            onPressed: () {
                              //itemProvider.addItem(item);
                              _itemSnackbar(item, context);
                            }),
                      ),
                      _ToggleButtonWidget(
                        item: item,
                        itemIndex: itemIndex,
                      ),
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
  }
}

void _itemSnackbar(Item item, BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    content: Container(
      height: kBottomNavigationBarHeight * 0.5,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        '${item.name} Added To Cart!  🛒',
        style: TextStyles.snackbartitle,
      ),
    ),
    duration: Duration(seconds: 1),
  ));
}

class _ToggleButtonWidget extends StatelessWidget {
  Item item;
  int itemIndex;

  _ToggleButtonWidget({@required this.item, @required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    return ToggleButtons(
      children: [
        ...item.sizes
            .map((size) => itemProvider.buildSelections(size.toString()))
      ],
      onPressed: (int index) {
        itemProvider.getSelectedButton(itemIndex, index);
      },
      //the index used below is the index provided by the listview builder
      isSelected: item.selections,
      fillColor: Colors.green,
      selectedColor: Colors.white,
      borderColor: Colors.grey[500],
    );
  }
}
