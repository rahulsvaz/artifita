import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  int _index = 0;
  int _answerCount = -1;
  bool _answer = false;
  bool _isOptionsEnabled = true;
  int _correctOptionIndex = -1;

  int get currentIndex => _index;
  int get answerCount => _answerCount;
  bool get answer => _answer;
  bool get isOptionsEnabled => _isOptionsEnabled;
  int get correctOptionIndex => _correctOptionIndex;

  void setAnswerCount(int count) {
    _answerCount = count;
    notifyListeners();
  }

  void setAnswer(bool value) {
    _answer = value;
    notifyListeners();
  }

  void setOptionsEnabled(bool value) {
    _isOptionsEnabled = value;
    notifyListeners();
  }

  void setCorrectOptionIndex(int index) {
    _correctOptionIndex = index;
    notifyListeners();
  }

  void incrementIndex() {
    _index++;
    notifyListeners();
  }

  void resetIndex() {
    _index = 0;
    notifyListeners();
  }

  void resetState() {
    _answerCount = -1;
    _answer = false;
    _isOptionsEnabled = true;
    _correctOptionIndex = -1;
    notifyListeners();
  }
}
