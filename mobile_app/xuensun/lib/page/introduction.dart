import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuensun/page/Login.dart';
import 'package:xuensun/widget/base_widget.dart';
import 'package:xuensun/widget/build_image.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  void _onIntroEnd(context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('intro_seen', true);

  // Mengecek status login pengguna
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    // Pengguna sudah login, arahkan ke Home
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
  } else {
    // Pengguna belum login, arahkan ke halaman login
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
  }
}


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topPadding = screenHeight * 0.08;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Kenali Stres, Rawat Diri",
              bodyWidget: const BaseWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Dengan XuenSun, masukkan data tidur dan aktivitas harian Anda untuk menganalisis tingkat stres dan mendapatkan tips untuk relaksasi lebih efektif.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              image: ImageBuilder(assetName: "intro1.png", height: 200),  // Consistent height for alignment
            ),
            PageViewModel(
              title: "Optimalkan Tidur untuk Mengurangi Stres",
              bodyWidget: const BaseWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Gunakan XuenSun untuk memasukkan data tidur Anda dan memahami pengaruhnya terhadap tingkat stres.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              image: ImageBuilder(assetName: "intro2.png", height: 200),  // Consistent height for alignment
            ),
            PageViewModel(
              title: "Pengaruh Gaya Hidup Terhadap Tingkat Stres",
              bodyWidget: const BaseWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Di XuenSun, sadari seberapa pentingnya gaya hidup mempengaruhi tingkat stres Anda.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              image: ImageBuilder(assetName: "intro3.png", height: 200),  // Consistent height for alignment
            ),
          ],
          onDone: () => _onIntroEnd(context),
          showBackButton: true,
          back: const Icon(Icons.arrow_back, color: Color.fromRGBO(26, 18, 11, 11)),
          next: const Icon(Icons.arrow_forward, color: Color.fromRGBO(26, 18, 11, 11)),
          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color.fromRGBO(200, 182, 166, 11),
            activeSize: Size(20.0, 10.0),
            activeColor: Color.fromRGBO(26, 18, 11, 11),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
