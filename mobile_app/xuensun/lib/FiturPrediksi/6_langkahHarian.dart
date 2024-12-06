import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/7_sleepDisorder.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';
import 'package:xuensun/widget/input_fitur.dart';
import 'package:xuensun/widget/snack_bar.dart'; // Import CustomSnackBar

// Daily Steps Input
class DailyStepsInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Langkah Kaki Harian'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          children: [
            CustomBoxWidget(text: "Berapa langkah rata-rata yang Anda tempuh setiap hari?",
            height: 150.0,
            ),
            const SizedBox(height: 100),
            InputFeatureWidget(
              labelText: 'Berapa Langkah',
              controller: predictionProvider.dailyStepsController,
              onChanged: (value) {
                predictionProvider.updateInputData(7, double.tryParse(value) ?? 0.0);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final dailySteps = double.tryParse(predictionProvider.dailyStepsController.text) ?? 0.0;

                // Validate the daily steps input
                if (dailySteps < 100 || dailySteps > 15000) {
                  // If the daily steps are outside the valid range, show a SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(
                      context,
                      'Langkah kaki harus antara 100 dan 15.000!',
                    ),
                  );
                  return; // Do not continue if invalid
                }

                // Navigate to the next screen if the daily steps are valid
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepDisorderInputScreen()),
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
