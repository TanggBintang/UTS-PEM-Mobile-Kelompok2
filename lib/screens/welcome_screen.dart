// File: lib/screens/welcome_screen.dart

import 'package:flutter/material.dart';
import 'quiz_screen.dart';

// Halaman welcome sebagai landing page aplikasi
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade200],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo atau ikon aplikasi
              Image.asset(
                'assets/icon/logoku.png',
                width: 300,
                height: 300,
              ),
              SizedBox(height: 10),

              // Judul aplikasi
              Text(
                'Quiz MI',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 10),

              // Subtitle atau deskripsi singkat
              Text(
                'Uji pengetahuanmu tentang\nManajemen Informatika',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 50),

              // Tombol untuk memulai quiz
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Mulai Quiz'),
              ),

              SizedBox(height: 20),

              // Informasi tambahan tentang aplikasi
              Text(
                'Created for D4 Manajemen Informatika',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}