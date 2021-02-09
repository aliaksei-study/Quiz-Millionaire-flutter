import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/Category.dart';
import 'package:quiz_millionaire_flutter_test/entity/Question.dart';
import 'package:quiz_millionaire_flutter_test/service/request/EditQuestionRequest.dart';
import 'package:quiz_millionaire_flutter_test/widgets/selectors/CategorySelector.dart';
import 'package:quiz_millionaire_flutter_test/widgets/selectors/DifficultySelector.dart';
import 'package:quiz_millionaire_flutter_test/service/Service.dart';

import '../main.dart';

class EditQuestionDialog extends StatefulWidget {
  final Question question;
  final Function(Question question) onQuestionUpdated;

  EditQuestionDialog({Key key, @required this.question, @required this.onQuestionUpdated}) : super(key: key);

  @override
  _EditQuestionDialogState createState() => _EditQuestionDialogState();
}

class _EditQuestionDialogState extends State<EditQuestionDialog> {

  Category updatedCategory;
  String updatedDifficulty;
  bool isTemporal;

  @override
  void initState() {
    setState(() {
      updatedCategory = widget.question.category;
      updatedDifficulty = widget.question.difficulty;
      isTemporal = widget.question.isTemporal;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DifficultySelector(
                difficulty: widget.question.difficulty,
                onDifficultyChange: (String difficulty) {
                  setState(() {
                    updatedDifficulty = difficulty;
                  });
                },
              ),
              CategorySelector(
                category: widget.question.category,
                onCategoryChange: (Category category) {
                  setState(() {
                    updatedCategory = category;
                  });
                },
              ),
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool selected) {
                      setState(() {
                        isTemporal = selected;
                      });
                    },
                    value: isTemporal,
                    activeColor: Color(0xFF6200EE),
                  ),
                  Text('Временный вопрос?'),
                ],
              ),
            ],
          )),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              showSpinnerDialog(context);
              EditQuestionRequest question = new EditQuestionRequest(category: updatedCategory, difficulty: updatedDifficulty, isTemporal: isTemporal);
              await updateQuestion(widget.question.id, question);
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new QuizTabBar(),
                ),
              );
            },
            child: Text("Сохранить")),
      ],
    );
  }
}