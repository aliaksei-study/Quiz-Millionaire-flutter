import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/Question.dart';

class ViewQuestionDialog extends StatelessWidget {
  final Question question;

  ViewQuestionDialog({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Просмотр вопроса'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Text('Текст вопроса',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 26)),
              Text(question.questionText,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('Ответы', style: TextStyle(fontSize: 26)))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < 4; i += 1)
                    Row(
                      children: [
                        Checkbox(
                          onChanged: null,
                          tristate: i == 1,
                          value: question.answers[i].isCorrect,
                          activeColor: Color(0xFF6200EE),
                        ),
                        Text(
                          question.answers[i].answerText,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: i == 4 ? Colors.black38 : Colors.black),
                        ),
                      ],
                    ),
                ],
              ),
              Text('Категория',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 26)),
              Text(question.category.categoryName,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text('Сложность',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26)),
                  )),
              Text(question.difficulty,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              Row(
                children: [
                  Checkbox(
                    onChanged: null,
                    value: question.isTemporal,
                    activeColor: Color(0xFF6200EE),
                  ),
                  Text('Временный вопрос?'),
                ],
              ),
            ]))));
  }
}
