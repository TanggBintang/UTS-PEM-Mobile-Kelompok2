class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Data pertanyaan quiz seputar pengetahuan dasar Manajemen Informatika
final List<Question> questions = [
  Question(
    questionText: "Apa kepanjangan dari MI dalam konteks program studi?",
    options: [
      "Management Information",
      "Manajemen Informatika",
      "Multimedia Information",
      "Manajemen Industri"
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Bahasa pemrograman yang biasanya diajarkan di semester awal MI adalah?",
    options: [
      "Python",
      "JavaScript",
      "Java",
      "C++"
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "Apa yang dimaksud dengan database?",
    options: [
      "Program untuk membuat grafik",
      "Kumpulan data yang terorganisir",
      "Jaringan komputer",
      "Perangkat keras komputer"
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Software yang digunakan untuk membuat tampilan website adalah?",
    options: [
      "Microsoft Word",
      "Adobe Photoshop",
      "Visual Studio Code",
      "Microsoft Excel"
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Algoritma adalah:",
    options: [
      "Perangkat keras komputer",
      "Program komputer",
      "Langkah-langkah penyelesaian masalah",
      "Bagian dari keyboard"
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Apa itu framework dalam konteks pengembangan aplikasi?",
    options: [
      "Rangka komputer",
      "Kerangka kerja pengembangan",
      "Bahasa pemrograman",
      "Sistem operasi"
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Manakah dari berikut yang merupakan bahasa markup?",
    options: [
      "Java",
      "Python",
      "HTML",
      "PHP"
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Apa fungsi utama dari SQL?",
    options: [
      "Membuat antarmuka pengguna",
      "Manajemen dan manipulasi database",
      "Membuat animasi",
      "Pemrograman mobile"
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Apa yang dimaksud dengan cloud computing?",
    options: [
      "Komputasi dengan komputer super",
      "Penyimpanan dan pengolahan data melalui internet",
      "Merakit komputer",
      "Menghitung cuaca"
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Apa itu UI/UX dalam pengembangan aplikasi?",
    options: [
      "Unit Interface/User Experience",
      "Uniform Interface/User Extension",
      "User Interface/User Experience",
      "Unified Interface/External"
    ],
    correctAnswerIndex: 2,
  ),
];