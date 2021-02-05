class Question {
  String questionText;
  String difficulty;

  Question({this.questionText, this.difficulty});

  static List<Question> getQuestions() {
    return <Question>[
      Question(questionText: "В каком году началась вторая мировая война?", difficulty: "EASY"),
      Question(questionText: "Автор романа война и мир?", difficulty: "MEDIUM"),
      Question(questionText: "Священное писание в философии древней Греции, которое сильно ценилось?", difficulty: "NIGHTMARE"),
      Question(questionText: "Вопрос?", difficulty: "EASY"),
      Question(questionText: "Позже доделаю?", difficulty: "EASY"),
      Question(questionText: "Другой вопрос?", difficulty: "EASY"),
    ];
}
}