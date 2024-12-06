import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:xuensun/widget/build_image.dart';
import 'home.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  void _onIntroEnd(context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
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
              title: "Dinda Ayu Aprilia (2209106095)",
              bodyWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Sebagai Developer Utama, Dinda memimpin pengembangan aplikasi dengan memastikan seluruh fitur berjalan lancar. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              image: Container(
                width: 200, // Tentukan lebar dan tinggi agar border rapi
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Bentuk lingkaran
                  border: Border.all(
                    width: 4, // Ketebalan border
                  ),
                ),
                child: ClipOval(
                  child: ImageBuilder(assetName: "dinda.png", height: 200),
                ),
              ),
            ),
            PageViewModel(
              title: "Vista Mellyna Atsfi (2209106096)",
              bodyWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Sebagai Pengembang Desain, Vista menghadirkan elemen visual yang estetis dan intuitif.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              image: Container(
                width: 200, // Tentukan lebar dan tinggi agar border rapi
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Bentuk lingkaran
                  border: Border.all(
                    width: 4, // Ketebalan border
                  ),
                ),
                child: ClipOval(
                  child: ImageBuilder(assetName: "vista.png", height: 200),
                ),
              ),
            ),
            PageViewModel(
              title: "Andi Zahrina Athirah Ahmad (2209106126)",
              bodyWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Sebagai Penyusun Data Kecerdasan Buatan, Zahrina bertanggung jawab dalam merancang model prediksi yang cerdas dan akurat.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              image: Container(
                width: 200, // Tentukan lebar dan tinggi agar border rapi
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Bentuk lingkaran
                  border: Border.all(
                    width: 4, // Ketebalan border
                  ),
                ),
                child: ClipOval(
                  child: ImageBuilder(assetName: "arin.png", height: 200),
                ),
              ),
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
