import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/models/ticket_model.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/items_model.dart';

class LocalDatabase {
  //initiating the database variables
  static final _dbName = 'EMovies.db';
  static final _dbVersion = 1;

  //making the class a singleton
  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  static Database _database;

  //This getter function ensures that this class is onl instantiated once. it returns the database
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initiateDatabase();
    return _database;
  }

  //Initializing the database
  initiateDatabase() async {
    //Getting the application's directory
    String directory = await getDatabasesPath();
    //concatenating a string 'path' using the directory and the designated database name
    String path = join(directory, _dbName);

    print('Initialize database');

    await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate, /* onOpen: _onOpen */
    );
  }

  // Future<void> _onOpen(Database db) {
  //   _onCreate(db, 1);
  // }

  Future _onCreate(Database db, int version) async {
    print('creating database');

    try {
      await db.execute('''CREATE TABLE items(id INTEGER PRIMARY KEY,
        name TEXT,
        imgUrl TEXT,
        prices TEXT,
        selections TEXT,
        quantity INTEGER,
        sizes TEXT)''');

      await db.execute('''CREATE TABLE tickets(id INTEGER PRIMARY KEY, 
    movieTitle TEXT,
    userName TEXT,
    price INTEGER, 
    confirmed BOOL,
    type TEXT,
    quantity INTEGER,
    screening STRING, 
    dateTime STRING,
    active BOOL,
    movieImg TEXT,
    date TEXT,
    time TEXT,
    uid TEXT,
    movieID TEXT)''');
    } catch (e) {
      print('Error Creating Database' + e.toString());
    } on DatabaseException catch (e) {
      print('Some Database Error' + e.toString());
    }
    ;

    try {
      DatabaseService().itemCollection.snapshots().forEach((document) {
        document.docChanges.forEach((snapshot) {
          Item item = Item.fromData(snapshot.doc.data());
          db.insert('items', item.toMap());
        });
      });
    } catch (e) {
      print('Items error' + e.toString());
    }

    try {
      DatabaseService()
          .ticketCollection
          .where('uid', isEqualTo: await AuthService().getCurrentUser())
          .snapshots()
          .forEach((document) {
        document.docChanges.forEach((ticket) {
          db.insert('tickets', ticket.doc.data());
        });
      });
    } catch (e) {
      print('Tickets Error' + e.toString());
    }
  }

  void populateDb() async {}

  Future<List<Map<String, dynamic>>> getAResponse() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> _response = await db.query('tickets');

    return _response;
  }
}
