import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/result.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';

class PredictionResultScreen extends StatefulWidget {
  @override
  _PredictionResultScreenState createState() => _PredictionResultScreenState();
}

class _PredictionResultScreenState extends State<PredictionResultScreen> {
  Future<void> _onPredict(PredictionProvider predictionProvider) async {
    // Simpan salinan data sebelum prediksi
    final inputDataSnapshot = List<double>.from(predictionProvider.inputData);

    // Jalankan prediksi
    await predictionProvider.predict();

    // Periksa apakah widget masih terpasang
    if (!mounted) return;

    // Navigasi ke halaman hasil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          gender: inputDataSnapshot[0] == 1.0 ? 'Pria' : 'Wanita',
          age: inputDataSnapshot[1].toInt(),
          sleepDuration: inputDataSnapshot[2].toInt(),
          qualityOfSleep: inputDataSnapshot[3].toInt(),
          activityLevel: inputDataSnapshot[4].toInt(),
          bmiCategory: _getBMICategory(inputDataSnapshot[5].toInt()),
          heartRate: inputDataSnapshot[6].toInt(),
          dailySteps: inputDataSnapshot[7].toInt(),
          sleepDisorder: _getSleepDisorder(inputDataSnapshot[8].toInt()),
          predictionMessage: predictionProvider.predictionMessage ?? 'Hasil tidak tersedia',
        ),
      ),
      (Route<dynamic> route) => false, // Hapus semua halaman sebelumnya
    );
  }

  String _getBMICategory(int value) {
    switch (value) {
      case 0:
        return 'Normal';
      case 3:
        return 'Overweight';
      case 2:
        return 'Obese';
      case 4:
        return 'Underweight';
      default:
        return 'Unknown';
    }
  }

  String _getSleepDisorder(int value) {
    switch (value) {
      case 0:
        return 'Sleep Apnea';
      case 1:
        return 'Insomnia';
      case 2:
        return 'Tidak ada';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediksi Akhir'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Consumer<PredictionProvider>(
          builder: (context, predictionProvider, child) {
            return Column(
              children: [
                CustomBoxWidget(
                  text: "Gender: ${predictionProvider.inputData[0] == 1.0 ? 'Pria' : 'Wanita'}\n"
                      "Age: ${predictionProvider.inputData[1].toInt()} tahun\n"
                      "Sleep Duration: ${predictionProvider.inputData[2].toInt()} jam\n"
                      "Quality of Sleep: ${predictionProvider.inputData[3].toInt()}\n"
                      "Activity Level: ${predictionProvider.inputData[4].toInt()}\n"
                      "BMI Category: ${_getBMICategory(predictionProvider.inputData[5].toInt())}\n"
                      "Heart Rate: ${predictionProvider.inputData[6].toInt()} bpm\n"
                      "Daily Steps: ${predictionProvider.inputData[7].toInt()} langkah\n"
                      "Sleep Disorder: ${_getSleepDisorder(predictionProvider.inputData[8].toInt())}",
                  height: 400.0,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _onPredict(predictionProvider),
                  child: const Text('Predict'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
