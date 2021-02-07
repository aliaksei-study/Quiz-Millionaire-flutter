import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/Category.dart';
import 'package:quiz_millionaire_flutter_test/service/Service.dart';

/// This is the stateful widget that the main application instantiates.
class CategorySelector extends StatefulWidget {
  final Category category;

  CategorySelector({Key key, @required this.category}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CategorySelectorState extends State<CategorySelector> {
  Category category;
  List<Category> categories = [];
  List<DropdownMenuItem<String>> items = [];

  fetchCategories() async {
    categories = await getCategories();
    items = categories
        .map<DropdownMenuItem<String>>((Category value) {
      return DropdownMenuItem<String>(
        value: value.categoryName,
        child: Text(value.categoryName),
      );
    }).toList();
    setState(() {
      categories = categories;
      items = items;
    });
  }

  @override
  void initState() {
    category = widget.category;
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: category.categoryName,
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
          category = categories.firstWhere((element) => element.categoryName == newValue);
        });
      },
      items: items,
    );
  }
}
