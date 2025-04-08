
import 'package:flutter/foundation.dart';
import 'question_model.dart';

// Class QuizProvider bertanggung jawab untuk manajemen state quiz
class QuizProvider with ChangeNotifier {
  // Menyimpan indeks pertanyaan saat ini
  int _currentQuestionIndex = 0;

  // Menyimpan jawaban pengguna
  List<int?> _userAnswers = List.filled(questions.length, null);

  // Menyimpan status apakah quiz telah selesai
  bool _isQuizFinished = false;

  // Getter untuk mendapatkan pertanyaan saat ini
  Question get currentQuestion => questions[_currentQuestionIndex];

  // Getter untuk mendapatkan indeks pertanyaan saat ini
  int get currentQuestionIndex => _currentQuestionIndex;

  // Getter untuk mendapatkan total pertanyaan
  int get totalQuestions => questions.length;

  // Getter untuk mendapatkan jawaban pengguna
  List<int?> get userAnswers => _userAnswers;

  // Getter untuk mendapatkan status apakah quiz telah selesai
  bool get isQuizFinished => _isQuizFinished;

  // Method untuk mendapatkan pertanyaan berdasarkan indeks
  Question getQuestionAt(int index) {
    return questions[index];
  }

  // Getter untuk mendapatkan skor pengguna
  int get score {
    int correctAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      if (_userAnswers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }

    return correctAnswers;
  }

  // Method untuk menjawab pertanyaan
  void answerQuestion(int answerIndex) {
    _userAnswers[_currentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  // Method untuk pindah ke pertanyaan berikutnya
  void nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      _isQuizFinished = true;
      notifyListeners();
    }
  }

  // Method untuk pindah ke pertanyaan sebelumnya
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Method untuk memulai ulang quiz
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers = List.filled(questions.length, null);
    _isQuizFinished = false;
    notifyListeners();
  }
}