import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: SpinKitFoldingCube(
          color: Theme.of(context).primaryColor,
          size: MediaQuery.of(context).size.width / 5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
