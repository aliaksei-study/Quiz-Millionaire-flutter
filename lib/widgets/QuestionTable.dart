import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/question.dart';

/// This is the stateful widget that the main application instantiates.
class QuestionsTableWidget extends StatefulWidget {
  QuestionsTableWidget({Key key}) : super(key: key);

  @override
  _QuestionsTableWidgetState createState() => _QuestionsTableWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _QuestionsTableWidgetState extends State<QuestionsTableWidget> {
  List<Question> selectedQuestions;
  List<Question> questions;
  bool sort;

  @override
  void initState() {
    sort = false;
    selectedQuestions = [];
    questions = Question.getQuestions();
    questions.sort((a, b) => b.questionText.compareTo(a.questionText));
    super.initState();
  }

  Future<void> showAddingQuestionDialog(
      BuildContext context, Question question) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("dfvfvd"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Сохранить")),
            ],
          );
        });
  }

  onSelectedRow(bool selected, Question question) async {
    setState(() {
      if (selected) {
        selectedQuestions.add(question);
      } else {
        selectedQuestions.remove(question);
      }
    });
  }

  onSortColumn(int columnIndex, bool ascending) async {
    if (columnIndex == 0) {
      if (ascending) {
        questions.sort((a, b) => a.questionText.compareTo(b.questionText));
      } else {
        questions.sort((a, b) => b.questionText.compareTo(a.questionText));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            showBottomBorder: true,
            sortAscending: sort,
            sortColumnIndex: 0,
            columnSpacing: 10,
            columns: <DataColumn>[
              DataColumn(
                  label: Text(
                    'Текст вопроса',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                    onSortColumn(columnIndex, ascending);
                  }),
              DataColumn(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.bar_chart,
                      color: Colors.grey,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Text(
                  'Действие',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: questions
                .map((question) => DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected))
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      return null; // Use default value for other states and odd rows.
                    }),
                selected: selectedQuestions.contains(question),
                onSelectChanged: (b) {
                  onSelectedRow(b, question);
                },
                cells: [
                  DataCell(
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(question.questionText)),
                  ),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.bar_chart,
                        color: question.difficulty == "EASY"
                            ? Colors.grey
                            : question.difficulty == "MEDIUM"
                            ? Colors.orange
                            : question.difficulty == "HARD"
                            ? Colors.redAccent
                            : Colors.red,
                        size: 24.0,
                      ),
                    ],
                  )),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined),
                          iconSize: 24.0,
                          padding: EdgeInsets.zero,
                          color: Colors.blue,
                          tooltip: 'Показать описание',
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: 24.0,
                          padding: EdgeInsets.zero,
                          color: Colors.blue,
                          tooltip: 'Редактировать',
                          onPressed: () async {
                            await showAddingQuestionDialog(
                                context, question);
                          },
                        ),
                      ),
                    ],
                  ))
                ]))
                .toList(),
          ),
        ));
  }
}