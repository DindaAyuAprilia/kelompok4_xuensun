import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/final.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/button.dart';
import 'package:xuensun/widget/container_custom.dart';

// Sleep Disorder Input
class SleepDisorderInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Gangguan Tidur'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          children: [
            CustomBoxWidget(text: "Apakah Anda memiliki gangguan tidur (Sleep Disorder)?",
            height: 150.0,
            ),
            const SizedBox(height: 80),
            // Use CustomButton widget for sleep disorder options
            CustomButton(
              text: 'Sleep Apnea',
              textColor: Color.fromARGB(255, 26, 18, 11),
              backgroundColor: Color.fromRGBO(216, 187, 168, 0.777),
              borderColor: Color.fromARGB(255, 26, 18, 11),
              onPressed: () {
                predictionProvider.updateInputData(8, 0.0); // Set value to 0 for Sleep Apnea
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PredictionResultScreen()),
                ); // Navigate directly to next screen
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Insomnia',
              textColor: Color.fromARGB(255, 26, 18, 11),
              backgroundColor: Color.fromRGBO(216, 187, 168, 0.777),
              borderColor: Color.fromARGB(255, 26, 18, 11),
              onPressed: () {
                predictionProvider.updateInputData(8, 1.0); // Set value to 1 for Insomnia
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PredictionResultScreen()),
                ); // Navigate directly to next screen
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Tidak ada',
              textColor: Color.fromARGB(255, 26, 18, 11),
              backgroundColor: Color.fromRGBO(216, 187, 168, 0.777),
              borderColor: Color.fromARGB(255, 26, 18, 11),
              onPressed: () {
                predictionProvider.updateInputData(8, 2.0); // Set value to 2 for No Sleep Disorder
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PredictionResultScreen()),
                ); // Navigate directly to next screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
