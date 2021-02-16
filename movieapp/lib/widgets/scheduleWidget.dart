import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/services/database.dart';

void showBottomModalSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10, bottom: 5, left: 10),
                    constraints: BoxConstraints.expand(),
                    // color: Colors.black,
                    child: FittedBox(
                      child: Text('This week\'s Schedule:',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: FutureBuilder(
                      future: DatabaseService().getSchedule(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();
                        else
                          return InteractiveViewer(
                              child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            imageUrl: snapshot.data,
                          ));
                      }),
                ),
              ],
            ));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
