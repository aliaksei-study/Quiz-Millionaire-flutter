import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/widgets/LoginForm.dart';
import 'package:quiz_millionaire_flutter_test/widgets/PlayerTable.dart';
import 'package:quiz_millionaire_flutter_test/widgets/QuestionTable.dart';

void main() => runApp(Navigation());

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginForm(),
        '/admin-tabs': (context) => QuizTabBar(),
      },
    );
  }
}

class QuizTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Text(
                  'Вопросы',
                  style: TextStyle(height: 2, fontSize: 18),
                ),
                Text(
                  'Игроки',
                  style: TextStyle(height: 2, fontSize: 18),
                ),
              ],
            ),
            title: Text('Администрирование'),
          ),
          body: TabBarView(
            children: [
              QuestionsTableWidget(),
              PlayersTableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
