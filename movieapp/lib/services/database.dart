import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  String get uid {}

  DatabaseService();

//collection references

//user collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

//ticket collection
  final CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

//movie collection
  final CollectionReference movieCollection =
      FirebaseFirestore.instance.collection('movies');

//items collection
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future updateUserData(
      String name, List<String> preferences, int points) async {
    return await userCollection.doc(uid).update({
      'name': name,
      'preferences': preferences,
    });
  }

//Updating user points
  Future updateUserPoints(int points) async {
    var currentPoints = await userCollection.doc();
  }

//Get user tickets
  Stream<QuerySnapshot> getUserTickets() async* {
    final uid = await AuthService().getCurrentUser();
    yield* ticketCollection.where('uid', isEqualTo: uid).snapshots();
  }

//Get Movies
  Stream<QuerySnapshot> getMovies(BuildContext context, bool onScreen) async* {
    yield* movieCollection.where('onscreen', isEqualTo: onScreen).snapshots();
  }

//Get Items
  Stream<QuerySnapshot> getItems() async* {
    yield* itemCollection.snapshots();
  }

/*
*****************Cloud Firestore Functions******************* 
*/

//Variables
  StorageReference movieStorage =
      FirebaseStorage.instance.ref().child("movies");
  StorageReference itemStorage = FirebaseStorage.instance.ref().child("items");

  Future<String> getPicture(String path) async {
    String imgUrl = await movieStorage.child(path).getDownloadURL();

    return imgUrl;
  }

  Future<String> getItemPicture(String path) async {
    String imgUrl = await itemStorage.child(path).getDownloadURL();

    return imgUrl;
  }

  Future<String> getSchedule() async {
    String imgUrl = await FirebaseStorage.instance
        .ref()
        .child("FB_IMG_1607457290285.jpg")
        .getDownloadURL();

    return imgUrl;
  }
}
