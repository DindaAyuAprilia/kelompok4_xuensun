import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xuensun/page/drawer.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================================================================================
      // [1] App bar
      appBar: AppBar(
        title: const Text('XuenSun'),
        backgroundColor: const Color.fromARGB(255, 26, 18, 11),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },  // Settings action
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
            tooltip: 'Setting',
          ),
          IconButton(
            onPressed: () {
              // Exit the app
              SystemNavigator.pop();
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,  // Icon for exit
              size: 30,
            ),
            tooltip: 'Exit',  
          ),
          
        ],
      ),
      // =========================================================================================
      // [2] Drawer
      drawer: const DrawerScreen(), // Menampilkan drawer di halaman home
      // =========================================================================================
      // [3] Base Widget dengan media query agar responsif dengan perubahan ukuran layar
      body: BaseWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),  // Space below the logo
                child: Image.asset('assets/logo.png', width: 120),  // Logo image
              ),
              const Text(
                "XuenSun",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Selamat datang di XuenSun, aplikasi yang membantu Anda memahami tingkat stres dan membantu membuat hidup Anda lebih baik.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              CustomButton(
                text: "Mulai",
                textColor: Colors.white,
                backgroundColor: const Color.fromRGBO(26, 18, 11, 11),
                borderColor: const Color.fromRGBO(26, 18, 11, 11),
                onPressed: () {
                  Navigator.pushNamed(context, '/prediksi'); // Arahkan ke halaman CobaPage
                },
              ),
              CustomButton(
                text: "Keluar",
                textColor: const Color.fromRGBO(26, 18, 11, 11),
                backgroundColor: Colors.white,
                borderColor: const Color.fromRGBO(26, 18, 11, 11),
                onPressed: () => SystemNavigator.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
