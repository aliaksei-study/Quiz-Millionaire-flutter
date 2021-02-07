import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/Answer.dart';
import 'package:quiz_millionaire_flutter_test/entity/Question.dart';

class AddQuestionDialog extends StatefulWidget {
  AddQuestionDialog({Key key}) : super(key: key);

  @override
  _AddQuestionDialogState createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController firstAnswerController = TextEditingController();
  final TextEditingController secondAnswerController = TextEditingController();
  final TextEditingController thirdAnswerController = TextEditingController();
  final TextEditingController fourthAnswerController = TextEditingController();

  bool _firstAnswerChecked = false;
  bool _secondAnswerChecked = false;
  bool _thirdAnswerChecked = false;
  bool _fourthAnswerChecked = false;

  saveQuestion() async {
    List<Answer> answers = List.from([
      new Answer(
          id: null,
          answerText: firstAnswerController.value.text,
          isCorrect: _firstAnswerChecked),
      new Answer(
          id: null,
          answerText: secondAnswerController.value.text,
          isCorrect: _secondAnswerChecked),
      new Answer(
          id: null,
          answerText: thirdAnswerController.value.text,
          isCorrect: _thirdAnswerChecked),
      new Answer(
          id: null,
          answerText: fourthAnswerController.value.text,
          isCorrect: _fourthAnswerChecked)
    ]);
    Question question = new Question(
        id: null,
        difficulty: null,
        questionText: questionTextController.value.text,
        answers: answers,
        category: null,
        isTemporal: true);
  }

  Future<void> _showInvalidCheckboxDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Должен быть отмечен правильный вопрос!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Продолжить'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Создание вопроса'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                        controller: questionTextController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Введите текст вопроса';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Вопрос',
                            hintText: 'Введите текст вопроса...',
                            border: OutlineInputBorder())),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(children: [
                                Checkbox(
                                    value: _firstAnswerChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _firstAnswerChecked = value;
                                      });
                                    }),
                              ])),
                          Expanded(
                              flex: 9,
                              child: Column(children: [
                                TextFormField(
                                    controller: firstAnswerController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Введите текст первого ответа';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Первый ответ',
                                        hintText:
                                            'Введите текст первого ответа...',
                                        border: OutlineInputBorder())),
                              ])),
                        ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(children: [
                                Checkbox(
                                    value: _secondAnswerChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _secondAnswerChecked = value;
                                      });
                                    }),
                              ])),
                          Expanded(
                              flex: 9,
                              child: Column(children: [
                                TextFormField(
                                    controller: secondAnswerController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Введите текст второго ответа';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Второй ответ',
                                        hintText:
                                            'Введите текст второго ответа...',
                                        border: OutlineInputBorder())),
                              ])),
                        ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(children: [
                                Checkbox(
                                    value: _thirdAnswerChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _thirdAnswerChecked = value;
                                      });
                                    }),
                              ])),
                          Expanded(
                              flex: 9,
                              child: Column(children: [
                                TextFormField(
                                    controller: thirdAnswerController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Введите текст третьего ответа';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Третий ответ',
                                        hintText:
                                            'Введите текст третьего ответа...',
                                        border: OutlineInputBorder())),
                              ])),
                        ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(children: [
                                Checkbox(
                                    value: _fourthAnswerChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _fourthAnswerChecked = value;
                                      });
                                    }),
                              ])),
                          Expanded(
                              flex: 9,
                              child: Column(children: [
                                TextFormField(
                                    controller: fourthAnswerController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Введите текст четвертого ответа';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Четвертый ответ',
                                        hintText:
                                            'Введите текст четвертого ответа...',
                                        border: OutlineInputBorder())),
                              ])),
                        ])),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if ((_firstAnswerChecked && !_secondAnswerChecked && !_thirdAnswerChecked && !_fourthAnswerChecked) ||
                                  (!_firstAnswerChecked &&
                                      _secondAnswerChecked &&
                                      !_thirdAnswerChecked &&
                                      !_fourthAnswerChecked) ||
                                  (!_firstAnswerChecked &&
                                      !_secondAnswerChecked &&
                                      _thirdAnswerChecked &&
                                      !_fourthAnswerChecked) ||
                                  (!_firstAnswerChecked &&
                                      !_secondAnswerChecked &&
                                      !_thirdAnswerChecked &&
                                      _fourthAnswerChecked)) {
                                saveQuestion();
                              } else {
                                _showInvalidCheckboxDialog();
                              }
                            }
                          },
                          child: Text('Сохранить')),
                    ),
                  ],
                )))));
  }
}
