import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/6_langkahHarian.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';
import 'package:xuensun/widget/input_fitur.dart';
import 'package:xuensun/widget/snack_bar.dart'; // Import CustomSnackBar

// Heart Rate Input
class HeartRateInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detak Jantung'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          children: [
            CustomBoxWidget(text: "Berapa rata-rata denyut jantung Anda per menit? Letakkan jari di titik nadi untuk menghitung.",
            height: 150.0,
            ),
            const SizedBox(height: 100),
            InputFeatureWidget(
              labelText: 'Heart Rate (bpm)',
              controller: predictionProvider.heartRateController,
              onChanged: (value) {
                // Update the heart rate value in the provider
                predictionProvider.updateInputData(6, double.tryParse(value) ?? 0.0);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final heartRate = double.tryParse(predictionProvider.heartRateController.text) ?? 0.0;

                // Validate the heart rate input
                if (heartRate < 65 || heartRate > 150) {
                  // If the heart rate is outside the valid range, show a SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(
                      context,
                      'Detak jantung harus antara 65 dan 150 bpm!',
                    ),
                  );
                  return; // Do not continue if invalid
                }

                // Navigate to the next screen if the heart rate is valid
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyStepsInputScreen()),
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
