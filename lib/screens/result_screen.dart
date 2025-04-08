
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_provider.dart';
import '../models/question_model.dart';  // Tambahkan import untuk model pertanyaan
import 'welcome_screen.dart';

// Halaman hasil yang menampilkan skor dan opsi untuk mencoba kembali
class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        final score = quizProvider.score;
        final totalQuestions = quizProvider.totalQuestions;
        final percentage = (score / totalQuestions) * 100;

        // Menentukan teks feedback berdasarkan persentase nilai
        String feedbackText;
        Color feedbackColor;
        IconData feedbackIcon;

        if (percentage >= 80) {
          feedbackText = 'Luar Biasa!';
          feedbackColor = Colors.green;
          feedbackIcon = Icons.emoji_events;
        } else if (percentage >= 60) {
          feedbackText = 'Bagus!';
          feedbackColor = Colors.blue;
          feedbackIcon = Icons.thumb_up;
        } else if (percentage >= 40) {
          feedbackText = 'Cukup Baik';
          feedbackColor = Colors.orange;
          feedbackIcon = Icons.check_circle;
        } else {
          feedbackText = 'Perlu Belajar Lagi';
          feedbackColor = Colors.red;
          feedbackIcon = Icons.book;
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  feedbackColor.withOpacity(0.8),
                  feedbackColor.withOpacity(0.3)
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ikon feedback
                  Icon(
                    feedbackIcon,
                    size: 100,
                    color: Colors.white,
                  ),

                  SizedBox(height: 20),

                  // Teks feedback
                  Text(
                    feedbackText,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Menampilkan skor
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Nilai Kamu:',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              percentage.toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: feedbackColor,
                              ),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: feedbackColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$score dari $totalQuestions pertanyaan benar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  // Tombol untuk melihat jawaban
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAnswersDialog(context, quizProvider);
                    },
                    icon: Icon(Icons.visibility),
                    label: Text('Lihat Jawaban'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: feedbackColor,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Tombol untuk mencoba kembali
                  ElevatedButton.icon(
                    onPressed: () {
                      quizProvider.resetQuiz();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()),
                            (route) => false,
                      );
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Coba Lagi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: feedbackColor,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Method untuk menampilkan dialog jawaban benar dan salah
  void _showAnswersDialog(BuildContext context, QuizProvider quizProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hasil Quiz'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: quizProvider.totalQuestions,
              itemBuilder: (context, index) {
                // Dapatkan pertanyaan dari QuizProvider
                final question = quizProvider.getQuestionAt(index);

                // Dapatkan jawaban pengguna dan jawaban yang benar
                final userAnswerIndex = quizProvider.userAnswers[index];
                final correctAnswerIndex = question.correctAnswerIndex;

                // Cek apakah jawaban benar
                final isCorrect = userAnswerIndex == correctAnswerIndex;

                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pertanyaan ${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),

                      // Tampilkan pertanyaan
                      Text(
                        question.questionText,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      SizedBox(height: 8),

                      // Tampilkan jawaban pengguna
                      if (userAnswerIndex != null)
                        Text(
                          'Jawaban kamu: ${question.options[userAnswerIndex]}',
                          style: TextStyle(
                            color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),

                      // Tampilkan jawaban yang benar jika jawaban pengguna salah
                      if (!isCorrect)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'Jawaban benar: ${question.options[correctAnswerIndex]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}