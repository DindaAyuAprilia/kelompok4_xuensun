import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionProvider with ChangeNotifier {
  List<double> inputData = List.filled(9, 0.0);  // 9 features
  String? predictionMessage;

  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sleepDurationController = TextEditingController();
  final TextEditingController qualityOfSleepController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();
  final TextEditingController bmiCategoryController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController dailyStepsController = TextEditingController();
  final TextEditingController sleepDisorderController = TextEditingController();

  // Function to update input data
  void updateInputData(int index, double value) {
    inputData[index] = value;
    notifyListeners();
  }

  // Function to send data to the API and receive a response
  Future<void> predict() async {
    final url = Uri.parse('https://xuensun.loca.lt/api/predict');  // Replace with your API URL
    final body = jsonEncode({
      'data': inputData,
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Assuming the response contains a 'prediction' field
        predictionMessage = data['prediction'] != null
            ? 'Tingkat Stress Anda: ${data['prediction']}'
            : 'Prediction failed.';
      } else {
        predictionMessage = 'Failed to get prediction.';
      }
      clearInputData();
      clearControllers();
    } catch (e) {
      predictionMessage = 'Error: $e';
    }
    notifyListeners();
  }

  // Function to clear input data
  void clearInputData() {
    inputData = List.filled(9, 0.0);
    notifyListeners();
  }

  // Function to clear all controllers
  void clearControllers() {
    genderController.clear();
    ageController.clear();
    sleepDurationController.clear();
    qualityOfSleepController.clear();
    activityLevelController.clear();
    bmiCategoryController.clear();
    heartRateController.clear();
    dailyStepsController.clear();
    sleepDisorderController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose controllers when the provider is no longer needed
    genderController.dispose();
    ageController.dispose();
    sleepDurationController.dispose();
    qualityOfSleepController.dispose();
    activityLevelController.dispose();
    bmiCategoryController.dispose();
    heartRateController.dispose();
    dailyStepsController.dispose();
    sleepDisorderController.dispose();
    super.dispose();
  }
}
