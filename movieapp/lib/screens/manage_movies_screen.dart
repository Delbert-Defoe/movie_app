import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:movieapp/configurations/textStyles.dart';
import 'package:movieapp/widgets/add_move_widgets.dart';

class ManageMoviesPage extends StatefulWidget {
  @override
  _ManageMoviesPageState createState() => _ManageMoviesPageState();
}

class _ManageMoviesPageState extends State<ManageMoviesPage> {
  var callable = FirebaseFunctions.instance.httpsCallable('addMovie');

  final _searchController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ratingController = TextEditingController();
  final _durationController = TextEditingController();

  var _dateTimes = <DateTime>[];

  @override
  void initState() {
    super.initState();

    // _movieFocusNode = FocusNode();

    _titleController.addListener(_printValues);
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Movies',
            style: TextStyles.pagetitle,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                _functionsRespone('Hello');
              },
            )
          ],
        ),
        body: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            children: [
              TextField(
                //focusNode: _movieFocusNode,
                controller: _searchController,

                showCursor: true,
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyles.textFieldValue,
                decoration: InputDecoration(
                    hintText: 'Search a movie title to auto complete ...',
                    hintStyle: TextStyles.textFieldLabel,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(width: 5, color: Colors.white)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor, size: 30)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: _screenHeight / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade400.withOpacity(0.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                      onPressed: () {
                        print('add a movie poster');
                      },
                    ),
                    Text(
                      'Add A Movie Poster',
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MovieInputFields(
                controller: _titleController,
                labelText: 'Movie Title',
              ),
              const SizedBox(
                height: 20,
              ),
              MovieInputFields(
                  controller: _descriptionController,
                  labelText: 'Movie Description'),
              const SizedBox(
                height: 20,
              ),
              MovieInputFields(
                controller: _ratingController,
                labelText: 'Movie Rating',
                maxLength: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              MovieInputFields(
                controller: _durationController,
                labelText: 'Movie Duration (Minutes)',
                maxLength: 3,
              ),
              ShowTimesWidget(
                  screenHeight: _screenHeight, dateTimes: _dateTimes)
            ]));
  }

  Future<String> _functionsRespone(String data) async {
    var response = await callable(data);
    print('this is the data ${response.data}');
    return response.data;
  }

  void _printValues() {
    print("Text Field val ${_titleController.text}");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _searchController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}
