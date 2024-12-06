import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/4_aktivitasFisik.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/container_custom.dart';
import 'package:xuensun/widget/range_picker.dart'; // Impor RangePicker
import 'package:xuensun/widget/snack_bar.dart'; // Impor CustomSnackBar

class QualityOfSleepInputScreen extends StatefulWidget {
  @override
  _QualityOfSleepInputScreenState createState() =>
      _QualityOfSleepInputScreenState();
}

class _QualityOfSleepInputScreenState extends State<QualityOfSleepInputScreen> {
  int _selectedQuality = 5; // Nilai kualitas tidur awal (misalnya 5)

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kualitas Tidur'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
      ),
      body: BaseWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomBoxWidget(text: "Berapa Anda menilai kualitas tidur Anda dalam skala 1–10? Sangat nyaman atau sebaliknya?"),
            const SizedBox(height: 100),
            const Text(
              'Pilih Kualitas Tidur (1-10)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Color.fromARGB(255, 26, 18, 11),
              child: Text('$_selectedQuality'),
              onPressed: () {
                // Menampilkan RangePicker untuk memilih kualitas tidur
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => Container(
                    height: 250,
                    color: CupertinoColors.systemBackground.resolveFrom(context),
                    child: SafeArea(
                      top: false,
                      child: RangePicker(
                        initialItem: _selectedQuality - 1,
                        rangeStart: 1,
                        rangeEnd: 10,
                        unit: '',
                        onItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedQuality = selectedItem + 1;
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
                if (_selectedQuality < 1 || _selectedQuality > 10) {
                  // Jika belum dipilih atau nilai tidak valid, tampilkan SnackBar peringatan
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.show(
                      context,
                      'Pilih nilai kualitas tidur antara 1 hingga 10!',
                    ),
                  );
                  return; // Tidak melanjutkan jika belum diisi
                }
        
                // Update data ke provider jika nilai valid
                predictionProvider.updateInputData(3, _selectedQuality.toDouble());
        
                // Navigasi ke halaman berikutnya
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ActivityLevelInputScreen()),
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
