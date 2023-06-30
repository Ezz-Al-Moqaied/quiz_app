import 'package:quiz_app/model/multipe_choice/questionMultiple.dart';

class QuizBrainMulti {
  int _questionNumber = 0;

  final List<QuestionMultiple> _questionBank = [
    QuestionMultiple('You can lead a cow down stairs but not up stairs.', 1,
        ['always', 'never', 'sometimes']),
    QuestionMultiple(
        'Approximately one quarter of human bones are in the feet.',
        0,
        ['agree', 'disagree', 'not sure']),
    QuestionMultiple(
        'What language do Flutter use ? ', 0, ['dart', 'java', 'kotlin']),
    QuestionMultiple('Flutter that work as applications for devices ? ', 2,
        ['Android', 'iPhone', 'All mentioned']),
    QuestionMultiple(
        'Do web application Flutter work? ? ', 2, ['yes', 'no', 'I don\'t know']),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getAllQuestionsNember() {
    return _questionBank.length;
  }

  int getQuestionNember() {
    return _questionNumber + 1;
  }

  List<String> getOptions() {
    return _questionBank[_questionNumber].options;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
