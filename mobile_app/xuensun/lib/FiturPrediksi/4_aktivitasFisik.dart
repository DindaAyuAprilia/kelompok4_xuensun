import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/5_detakJantung.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';
import 'package:xuensun/widget/range_picker.dart'; // Import RangePicker
import 'package:xuensun/widget/snack_bar.dart'; // Import CustomSnackBar

// Physical Activity Level Input
class ActivityLevelInputScreen extends StatefulWidget {
  @override
  _ActivityLevelInputScreenState createState() =>
      _ActivityLevelInputScreenState();
}

class _ActivityLevelInputScreenState extends State<ActivityLevelInputScreen> {
  int _selectedActivityLevel = 10; // Initial activity level (e.g., 10 minutes)

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivitas Fisik Harian'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          children: [
            CustomBoxWidget(text: "Berapa menit rata-rata Anda beraktivitas fisik dalam sehari?",
            height: 150.0,
            ),
            const SizedBox(height: 100),
            Text(
              'Pilih Aktivitas Fisik (Menit/hari)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Color.fromARGB(255, 26, 18, 11),
              child: Text('$_selectedActivityLevel Menit'),
              onPressed: () {
                // Show RangePicker for selecting activity level
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => Container(
                    height: 250,
                    color: CupertinoColors.systemBackground.resolveFrom(context),
                    child: SafeArea(
                      top: false,
                      child: RangePicker(
                        initialItem: _selectedActivityLevel - 10,
                        rangeStart: 10,
                        rangeEnd: 100,
                        unit: 'Menit',
                        onItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedActivityLevel = selectedItem + 10;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (_selectedActivityLevel < 10 || _selectedActivityLevel > 100) {
                  // If the value is invalid or not selected, show a SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(
                      context,
                      'Pilih nilai aktivitas fisik antara 10 hingga 100 menit!',
                    ),
                  );
                  return; // Do not continue if invalid
                }

                // Update the data in the provider if the value is valid
                predictionProvider.updateInputData(4, _selectedActivityLevel.toDouble());

                // Navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HeartRateInputScreen()),
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
