
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_provider.dart';
import 'result_screen.dart';

// Halaman quiz yang menampilkan pertanyaan dan pilihan jawaban
class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer untuk mendengarkan perubahan pada QuizProvider
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        // Jika quiz telah selesai, navigasikan ke halaman hasil
        if (quizProvider.isQuizFinished) {
          // Penggunaan WidgetsBinding untuk menjalankan navigasi setelah build selesai
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ResultScreen()),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Quiz MI'),
            backgroundColor: Colors.blue.shade800,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indicator pertanyaan saat ini dan total pertanyaan
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pertanyaan ${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      // Indikator progres
                      SizedBox(
                        width: 150,
                        child: LinearProgressIndicator(
                          value: (quizProvider.currentQuestionIndex + 1) /
                              quizProvider.totalQuestions,
                          backgroundColor: Colors.blue.shade100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue.shade800),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Teks pertanyaan
                Text(
                  quizProvider.currentQuestion.questionText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // Pilihan jawaban
                Expanded(
                  child: ListView.builder(
                    itemCount: quizProvider.currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      // Cek apakah pilihan ini adalah jawaban pengguna saat ini
                      final isSelected = quizProvider.userAnswers[
                      quizProvider.currentQuestionIndex] == index;

                      return GestureDetector(
                        onTap: () {
                          quizProvider.answerQuestion(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue.shade800
                                  : Colors.grey.shade300,
                              width: isSelected ? 2.0 : 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: isSelected
                                ? Colors.blue.shade50
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              // Indikator pilihan jawaban (A, B, C, D)
                              Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.blue.shade800
                                      : Colors.grey.shade200,
                                ),
                                child: Text(
                                  String.fromCharCode(65 + index), // 'A', 'B', 'C', 'D'
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              // Teks pilihan jawaban
                              Expanded(
                                child: Text(
                                  quizProvider.currentQuestion.options[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected
                                        ? Colors.blue.shade800
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                // Tombol navigasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol kembali
                    if (quizProvider.currentQuestionIndex > 0)
                      ElevatedButton.icon(
                        onPressed: () {
                          quizProvider.previousQuestion();
                        },
                        icon: Icon(Icons.arrow_back),
                        label: Text('Sebelumnya'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black87,
                        ),
                      )
                    else
                      SizedBox(width: 120), // Placeholder ketika tidak ada tombol kembali

                    // Tombol selanjutnya atau selesai
                    ElevatedButton.icon(
                      onPressed: quizProvider.userAnswers[
                      quizProvider.currentQuestionIndex] != null
                          ? () {
                        quizProvider.nextQuestion();
                      }
                          : null,
                      icon: Icon(Icons.arrow_forward),
                      label: Text(
                        quizProvider.currentQuestionIndex ==
                            quizProvider.totalQuestions - 1
                            ? 'Selesai'
                            : 'Selanjutnya',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}