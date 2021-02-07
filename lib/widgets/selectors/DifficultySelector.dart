import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class DifficultySelector extends StatefulWidget {
  final String difficulty;

  DifficultySelector({Key key, @required this.difficulty}) : super(key: key);

  @override
  _DifficultySelectorState createState() => _DifficultySelectorState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DifficultySelectorState extends State<DifficultySelector> {
  String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.difficulty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['EASY', 'MEDIUM', 'HARD', 'NIGHTMARE']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
