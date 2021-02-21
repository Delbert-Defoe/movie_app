import 'package:flutter/material.dart';
import 'package:movieapp/configurations/textStyles.dart';

class MovieInputFields extends StatefulWidget {
  MovieInputFields(
      {Key key,
      @required this.controller,
      this.hintText,
      this.maxLength,
      @required this.labelText})
      : super(key: key);

  String hintText;
  String labelText;
  TextEditingController controller;
  int maxLength = null;

  @override
  _MovieInputFieldsState createState() => _MovieInputFieldsState();
}

class _MovieInputFieldsState extends State<MovieInputFields> {
  FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        focusNode: focusNode,
        minLines: 1,
        maxLines: 1000,
        maxLength: widget.maxLength,
        controller: widget.controller,
        style: TextStyles.textFieldValue,
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyles.textFieldLabel,
            border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor))));
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

class ShowTimesWidget extends StatefulWidget {
  const ShowTimesWidget({
    Key key,
    @required double screenHeight,
    @required List<DateTime> dateTimes,
  })  : _screenHeight = screenHeight,
        _dateTimes = dateTimes,
        super(key: key);

  final double _screenHeight;
  final List<DateTime> _dateTimes;

  @override
  _ShowTimesWidgetState createState() => _ShowTimesWidgetState();
}

class _ShowTimesWidgetState extends State<ShowTimesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._screenHeight / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade400.withOpacity(0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(color: Colors.white, height: 20),
          itemCount: widget._dateTimes.length + 1,
          itemBuilder: (context, index) {
            if (index == widget._dateTimes.length) {
              return FlatButton.icon(
                label: Text(
                  'Add Show time',
                  style: TextStyles.textFieldLabel,
                ),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  _chooseDate();
                },
              );
            } else {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget._dateTimes[index].toString(),
                      style: TextStyles.textFieldValue,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _deleteShowTime(context, index);
                      },
                    )
                  ]);
            }
          },
        ),
      ),
    );
  }

  void _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2025),
    ).then((date) => {
          showTimePicker(
                  context: context, initialTime: TimeOfDay(hour: 18, minute: 0))
              .then((time) => {
                    setState(() {
                      if (date == null) {
                        return;
                      }
                      widget._dateTimes.add(DateTime(date.year, date.month,
                          date.day, time.hour, time.minute));
                    }),
                  })
        });
  }

  void _deleteShowTime(context, index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Delete Show Time?',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.black,
                      fontSize: 18)),
              content: Text(widget._dateTimes[index].toString(),
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Theme.of(context).primaryColor,
                      fontSize: 18)),
              actions: [
                FlatButton(
                  child: Text('No',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      widget._dateTimes.removeAt(index);
                      Navigator.of(context).pop();
                    });
                  },
                )
              ]);
        });
  }
}
