import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/Category.dart';
import 'package:quiz_millionaire_flutter_test/entity/Question.dart';
import 'package:quiz_millionaire_flutter_test/service/Service.dart';
import 'package:quiz_millionaire_flutter_test/widgets/AddQuestionDialog.dart';
import 'package:quiz_millionaire_flutter_test/widgets/EditQuestionDialog.dart';
import 'package:quiz_millionaire_flutter_test/widgets/ViewQuestionDialog.dart';
import 'package:quiz_millionaire_flutter_test/widgets/selectors/CategorySelector.dart';
import 'package:quiz_millionaire_flutter_test/widgets/selectors/DifficultySelector.dart';

/// This is the stateful widget that the main application instantiates.
class QuestionsTableWidget extends StatefulWidget {
  QuestionsTableWidget({Key key}) : super(key: key);

  @override
  _QuestionsTableWidgetState createState() => _QuestionsTableWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _QuestionsTableWidgetState extends State<QuestionsTableWidget> {
  List<Question> selectedQuestions = [];
  List<Question> questions = [];
  bool sort;

  fetchQuestions(BuildContext context) async {
    questions = await getQuestions();
    questions.sort((a, b) => b.questionText.compareTo(a.questionText));
    setState(() {
      questions = questions;
    });
  }

  @override
  void initState() {
    Timer.run(() async {
      showSpinnerDialog(context);
      await fetchQuestions(context);
      Navigator.of(context, rootNavigator: true).pop();
    });
    sort = false;
    selectedQuestions = [];
    super.initState();
  }

  updateQuestions(Question updatedQuestion) {
    setState(() {
      int questionPosition =
          questions.indexWhere((element) => element.id == updatedQuestion.id);
      questions.replaceRange(
          questionPosition, questionPosition + 1, List.from([updatedQuestion]));
    });
  }

  Future<void> showEditingQuestionDialog(
      BuildContext context, Question question) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return EditQuestionDialog(
              question: question,
              onQuestionUpdated: (Question question) {
                updateQuestions(question);
              });
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

  onQuestionAdded(Question question) {
    setState(() {
      questions.add(question);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AddQuestionDialog(onQuestionAdded: onQuestionAdded,),
                      fullscreenDialog: true,
                    ),
                  );
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Добавить вопрос',
                      style: TextStyle(fontSize: 20)),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (selectedQuestions.isNotEmpty) {
                    //todo request
                  }
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFFD70F16),
                        Color(0xFF84222B),
                        Color(0xFF973F4A),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Удалить', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          )),
      DataTable(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ViewQuestionDialog(question: question),
                                    fullscreenDialog: true,
                                  ),
                                );
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
                                await showEditingQuestionDialog(
                                    context, question);
                              },
                            ),
                          ),
                        ],
                      ))
                    ]))
            .toList(),
      ),
    ]));
  }
}
