import 'dart:math';
import 'package:flutter/material.dart';

class CustomBoxWidget extends StatelessWidget {
  final String text;
  final double height; // Tambahkan parameter height

  const CustomBoxWidget({Key? key, required this.text, this.height = 150.0}) : super(key: key); // Default height jika tidak diberikan

  @override
  Widget build(BuildContext context) {
    final random = Random();
    List<Positioned> circles = [];
    Set<Offset> placedOffsets = {}; // Untuk melacak posisi lingkaran yang sudah ditempatkan

    // Membuat posisi acak untuk beberapa lingkaran
    for (int i = 0; i < 5; i++) {
      double circleX;
      double circleY;

      // Pastikan lingkaran memiliki jarak minimal 20 unit
      do {
        circleX = random.nextDouble() * 300.0; // Rentang lebar maksimum
        circleY = random.nextDouble() * height; // Rentang tinggi disesuaikan dengan height
      } while (_isTooClose(circleX, circleY, placedOffsets)); // Periksa apakah posisi terlalu dekat

      // Menambahkan posisi baru ke dalam set
      placedOffsets.add(Offset(circleX, circleY));

      // Menambahkan lingkaran ke dalam list
      circles.add(Positioned(
        left: circleX,
        top: circleY,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(216, 187, 168, 0.777),
            shape: BoxShape.circle,
          ),
        ),
      ));
    }

    return Column(
      children: [
        // Stack untuk menempatkan lingkaran di belakang kotak teks
        Stack(
          children: [
            // Kontainer latar belakang dengan beberapa lingkaran
            Container(
              width: 350,
              height: height, // Gunakan nilai height yang diberikan
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 26, 18, 11), // Warna latar belakang
                borderRadius: const BorderRadius.only( // Radius hanya di bagian bawah
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Stack(children: circles), // Menambahkan lingkaran ke dalam Stack
            ),
            // Kontainer kotak teks
            Positioned(
              left: 25, // Offset untuk menciptakan tampilan yang lebih baik
              top: 25,
              child: Container(
                width: 280,
                height: height-50,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Center( // Menjadikan teks terpusat
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0, // Padding atas-bawah
                        horizontal: 8.0, // Padding kiri-kanan
                      ),
                      child: Text(
                        text, // Menampilkan teks yang diterima
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center, // Menambahkan pengaturan alignment teks
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Fungsi untuk memeriksa apakah lingkaran terlalu dekat dengan lingkaran lainnya
  bool _isTooClose(double x, double y, Set<Offset> placedOffsets) {
    const minDistance = 20.0; // Jarak minimum antara lingkaran
    for (var offset in placedOffsets) {
      double dx = x - offset.dx;
      double dy = y - offset.dy;
      double distance = sqrt(dx * dx + dy * dy);
      if (distance < minDistance) {
        return true; // Lingkaran terlalu dekat
      }
    }
    return false; // Lingkaran tidak terlalu dekat
  }
}
