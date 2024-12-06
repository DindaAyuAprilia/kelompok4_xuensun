import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/3_qualitySleep.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';
import 'package:xuensun/widget/snack_bar.dart';
import 'package:xuensun/widget/range_picker.dart'; // Impor RangePicker

class SleepDurationInputScreen extends StatefulWidget {
  @override
  State<SleepDurationInputScreen> createState() =>
      _SleepDurationInputScreenState();
}

class _SleepDurationInputScreenState extends State<SleepDurationInputScreen> {
  int _selectedDuration = 1; // Durasi awal (1 jam)

  // Menampilkan CupertinoPicker di dalam dialog modal
  void _showPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: RangePicker(
            initialItem: _selectedDuration - 1,
            rangeStart: 1,
            rangeEnd: 10,
            unit: 'jam',
            onItemChanged: (int selectedItem) {
              setState(() {
                _selectedDuration = selectedItem + 1;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Durasi Tidur'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Pusatkan konten di tengah vertikal
          children: [
            CustomBoxWidget(text: "Berapa jam rata-rata durasi tidur Anda setiap malam?",
            height: 150.0,
            ),
            const SizedBox(height: 100),
            const Text(
              'Pilih Durasi Tidur',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Color.fromARGB(255, 26, 18, 11),
              child: Text('$_selectedDuration jam'),
              onPressed: () => _showPicker(context),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (_selectedDuration < 1 || _selectedDuration > 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(
                        context, 'Durasi tidur harus antara 1 dan 10 jam.'),
                  );
                  return;
                }
        
                // Update data ke provider
                predictionProvider.updateInputData(2, _selectedDuration.toDouble());
        
                // Navigasi ke halaman berikutnya
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QualityOfSleepInputScreen()),
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
