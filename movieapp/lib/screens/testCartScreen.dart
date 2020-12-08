import 'package:flutter/material.dart';
import 'package:movieapp/models/items_model.dart';
import 'package:provider/provider.dart';

class CartScreenTest extends StatelessWidget {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    var items = itemProvider.cart;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: AnimatedList(
            key: _key,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(items[index], animation, index, context);
            }),
      ),
    );
  }

  Widget _buildItem(
      CartItem item, Animation animation, int index, BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
            child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(item.imgUrl),
          ),
          title: Text(item.name),
          subtitle: Text('${item.size}: \$${item.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              itemProvider.removeItem(index);
              _removeItem(index, context);
            },
          ),
        )));
  }

  void _removeItem(int index, BuildContext context) {
    var itemProvider = Provider.of<ItemProvider>(context);
    var items = itemProvider.cart;
    var removedItem = items.removeAt(index);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation, index, context);
    };

    _key.currentState.removeItem(index, builder);
  }
}
