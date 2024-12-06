import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/2_sleepDuration.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';
import 'package:xuensun/widget/input_fitur.dart';
import 'package:xuensun/widget/snack_bar.dart';

// Gabungan dari Input untuk Gender, Umur, Tinggi Badan, dan Berat Badan
class GeneralInputScreen extends StatefulWidget {
  @override
  _GeneralInputScreenState createState() => _GeneralInputScreenState();
}

class _GeneralInputScreenState extends State<GeneralInputScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  int? genderValue; // Untuk menyimpan nilai gender (0 untuk Male, 1 untuk Female)

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Umum'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          children: [
            CustomBoxWidget(text: "Silahkan jawab pertanyaan di bawah ini:",
            height: 150.0,
            ),
            // Input untuk Gender dengan Radio Button
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontSize: 14, // Ukuran font 14
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: genderValue,
                  onChanged: (int? value) {
                    setState(() {
                      genderValue = value;
                      predictionProvider.updateInputData(0, value?.toDouble() ?? 0.0);
                    });
                  },
                ),
                const Text('Pria'),
                Radio<int>(
                  value: 0,
                  groupValue: genderValue,
                  onChanged: (int? value) {
                    setState(() {
                      genderValue = value;
                      predictionProvider.updateInputData(0, value?.toDouble() ?? 0.0);
                    });
                  },
                ),
                const Text('Wanita'),
              ],
            ),
            // Input untuk Umur
            const SizedBox(height: 20),
            InputFeatureWidget(
              labelText: 'Umur',
              controller: predictionProvider.ageController,
              onChanged: (value) {
                double age = double.tryParse(value) ?? 0.0;
                if (age >= 5 && age <= 100) {
                  predictionProvider.updateInputData(1, age);
                } else {
                  // // Menampilkan pesan kesalahan jika umur tidak dalam rentang yang valid
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   CustomSnackBar.show(context, 'Umur harus antara 5 dan 100')
                  // );
                }
              },
            ),
            // Input untuk Tinggi Badan
            const SizedBox(height: 20),
            InputFeatureWidget(
              labelText: 'Tinggi Badan (dalam cm)',
              controller: heightController,
              onChanged: (value) {
                double height = double.tryParse(value) ?? 0.0;
                if (height >= 62 && height <= 248) {
                  // Tinggi badan valid
                } else {
                  // Menampilkan pesan kesalahan jika tinggi badan tidak dalam rentang yang valid
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   CustomSnackBar.show(context, 'Tinggi badan harus antara 62 dan 248 cm'),
                  // );
                }
              },
            ),
            // Input untuk Berat Badan
            const SizedBox(height: 20),
            InputFeatureWidget(
              labelText: 'Berat Badan (dalam kg)',
              controller: weightController,
              onChanged: (value) {
                double weight = double.tryParse(value) ?? 0.0;
                if (weight >= 15 && weight <= 300) {
                  // Berat badan valid
                } else {
                  // Menampilkan pesan kesalahan jika berat badan tidak dalam rentang yang valid
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   CustomSnackBar.show(context, 'Berat badan harus antara 15 dan 300 kg'),
                  // );
                }
              },
            ),
            const SizedBox(height: 20),
            // Tombol untuk melanjutkan ke halaman Durasi Tidur
            ElevatedButton(
              onPressed: () {
                // Ambil nilai dari semua input
                final double height = double.tryParse(heightController.text) ?? 0.0;
                final double weight = double.tryParse(weightController.text) ?? 0.0;
                final int? gender = genderValue;
                final int age = double.tryParse(predictionProvider.ageController.text)?.toInt() ?? 0;

                // Validasi input
                if (gender == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(context, 'Pilih jenis kelamin.'),
                  );
                  return;
                }

                if (age < 5 || age > 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(context, 'Umur harus antara 5 dan 100 tahun.'),
                  );
                  return;
                }

                if (height < 62 || height > 248) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(context, 'Tinggi badan harus antara 62 dan 248 cm.'),
                  );
                  return;
                }

                if (weight < 15 || weight > 300) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(context, 'Berat badan harus antara 15 dan 300 kg.'),
                  );
                  return;
                }

                // Jika semua validasi lolos, hitung BMI
                final double heightInMeters = height / 100;
                final double bmi = weight / (heightInMeters * heightInMeters);

                // Tentukan kategori BMI berdasarkan gender dan umur
                int category;
                if (gender == 1) { // Pria
                  if (age <= 18) {
                    if (bmi < 18.0) {
                      category = 4; // Underweight
                    } else if (bmi < 23.0) {
                      category = 0; // Normal
                    } else if (bmi < 27.0) {
                      category = 3; // Overweight
                    } else {
                      category = 2; // Obese
                    }
                  } else {
                    if (bmi < 18.5) {
                      category = 4;
                    } else if (bmi < 25.0) {
                      category = 0;
                    } else if (bmi < 30.0) {
                      category = 3;
                    } else {
                      category = 2;
                    }
                  }
                } else { // Wanita
                  if (age <= 18) {
                    if (bmi < 17.5) {
                      category = 4;
                    } else if (bmi < 22.5) {
                      category = 0;
                    } else if (bmi < 26.5) {
                      category = 3;
                    } else {
                      category = 2;
                    }
                  } else {
                    if (bmi < 18.0) {
                      category = 4;
                    } else if (bmi < 24.0) {
                      category = 0;
                    } else if (bmi < 29.0) {
                      category = 3;
                    } else {
                      category = 2;
                    }
                  }
                }

                // Update data ke provider
                predictionProvider.updateInputData(5, category.toDouble());

                // Reset field
                heightController.clear();
                weightController.clear();

                // Navigasi ke halaman berikutnya
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepDurationInputScreen()),
                );
              },
              child: const Text('Next'),
            ),

          ],
        ),
      ),
    );
  }
}
