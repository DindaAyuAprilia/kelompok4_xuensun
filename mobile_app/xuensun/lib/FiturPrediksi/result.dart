import 'package:flutter/material.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/button.dart';
import 'package:xuensun/widget/container_custom.dart';

class ResultScreen extends StatelessWidget {
  final String gender;
  final int age;
  final int sleepDuration;
  final int qualityOfSleep;
  final int activityLevel;
  final String bmiCategory;
  final int heartRate;
  final int dailySteps;
  final String sleepDisorder;
  final String predictionMessage;

  const ResultScreen({
    Key? key,
    required this.gender,
    required this.age,
    required this.sleepDuration,
    required this.qualityOfSleep,
    required this.activityLevel,
    required this.bmiCategory,
    required this.heartRate,
    required this.dailySteps,
    required this.sleepDisorder,
    required this.predictionMessage,
  }) : super(key: key);
  

  String getTips() {
    List<String> tips = [];

    // Tips berdasarkan usia
    if (age >= 15 && age <= 30) {
      tips.add(
          "Anda berada dalam rentang usia 15-30 tahun yang rentan terhadap stres karena tekanan pekerjaan atau pendidikan. Pastikan Anda mengambil waktu untuk bersantai.");
    }

    // Tips berdasarkan durasi tidur
    if (sleepDuration < 6) {
      tips.add(
          "Durasi tidur Anda kurang dari 6 jam. Usahakan untuk tidur lebih awal dan hindari penggunaan gadget sebelum tidur.");
    } else if (sleepDuration <= 7) {
      tips.add(
          "Durasi tidur Anda cukup, namun masih bisa ditingkatkan untuk kualitas tidur yang lebih baik.");
    } else {
      tips.add("Durasi tidur Anda sangat baik. Pertahankan pola tidur ini!");
    }

    // Tips berdasarkan kualitas tidur
    if (qualityOfSleep < 5) {
      tips.add(
          "Kualitas tidur Anda kurang baik. Cobalah menciptakan suasana kamar tidur yang nyaman dan hindari stres sebelum tidur.");
    } else if (qualityOfSleep <= 7) {
      tips.add(
          "Kualitas tidur Anda sedang. Cobalah menjaga rutinitas tidur yang konsisten untuk meningkatkan kualitasnya.");
    } else {
      tips.add("Kualitas tidur Anda sangat baik. Pertahankan kebiasaan tidur sehat ini!");
    }

    // Tips berdasarkan aktivitas fisik
    if (activityLevel < 30) {
      tips.add("Tingkat aktivitas fisik Anda rendah. Usahakan untuk berjalan kaki minimal 30 menit setiap hari.");
    } else if (activityLevel <= 60) {
      tips.add("Aktivitas fisik Anda sedang. Cobalah untuk meningkatkan intensitas aktivitas Anda secara bertahap.");
    } else {
      tips.add("Aktivitas fisik Anda sangat baik. Pertahankan kebiasaan sehat ini!");
    }

    // Tips berdasarkan jumlah langkah harian
    if (dailySteps < 5000) {
      tips.add(
          "Jumlah langkah harian Anda rendah (<5000 langkah). Tingkatkan aktivitas harian Anda dengan berjalan lebih banyak, seperti memilih tangga daripada lift.");
    } else if (dailySteps <= 10000) {
      tips.add(
          "Jumlah langkah harian Anda sedang (5000-10000 langkah). Cobalah mencapai 10.000 langkah untuk manfaat kesehatan yang lebih baik.");
    } else {
      tips.add(
          "Jumlah langkah harian Anda sangat baik (>10.000 langkah). Pertahankan gaya hidup aktif ini!");
    }

    // Tips berdasarkan gangguan tidur
    if (sleepDisorder == "Sleep Apnea") {
      tips.add(
          "Anda memiliki gangguan tidur Sleep Apnea. Konsultasikan dengan dokter untuk penanganan lebih lanjut.");
    } else if (sleepDisorder == "Insomnia") {
      tips.add(
          "Anda memiliki gangguan tidur Insomnia. Hindari konsumsi kafein dan cobalah meditasi sebelum tidur.");
    }

    // Tips berdasarkan kategori BMI
    if (bmiCategory == "Underweight") {
      tips.add(
          "Berat badan Anda berada di bawah normal. Konsumsilah makanan bergizi yang kaya akan protein, karbohidrat kompleks, dan lemak sehat. Jangan lupa untuk makan secara teratur.");
    } else if (bmiCategory == "Normal") {
      tips.add(
          "Berat badan Anda dalam kisaran normal. Pertahankan pola makan seimbang dan rutin berolahraga untuk menjaga kesehatan.");
    } else if (bmiCategory == "Overweight") {
      tips.add(
          "Berat badan Anda sedikit di atas normal. Kurangi konsumsi makanan tinggi gula dan lemak jenuh, serta perbanyak konsumsi sayur dan buah.");
    } else if (bmiCategory == "Obese") {
      tips.add(
          "Berat badan Anda berada di kategori obesitas. Segera konsultasikan dengan ahli gizi untuk mendapatkan panduan pola makan yang sehat dan rencana olahraga yang sesuai.");
    }

    return tips.join("\n\n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Prediksi'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomBoxWidget(
                text: " $predictionMessage",
                height: 100.0,
              ),
              const SizedBox(height: 20),
              CustomBoxWidget(
                text: "Tips Mengurangi Stres:\n\n${getTips()}",
                height: 500.0,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: "Home",
                    textColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 26, 18, 11),
                    borderColor: const Color.fromARGB(255, 26, 18, 11),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home'); // Arahkan ke halaman Home
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}