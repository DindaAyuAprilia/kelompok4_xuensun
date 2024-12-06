import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuensun/FiturPrediksi/1_general.dart';
import 'package:xuensun/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuensun/page/Regis.dart';
import 'package:xuensun/page/about_us.dart';
import 'package:xuensun/page/home.dart';
import 'package:xuensun/page/introduction.dart';
import 'package:xuensun/page/setting.dart';
import 'package:xuensun/controller/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'firebase_options.dart'; // Pastikan Anda telah menambahkan file firebase_options.dart
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:xuensun/page/login.dart'; // Import Login page

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan Flutter sudah terinisialisasi
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inisialisasi Firebase
  );
  runApp(const MyApp()); // Jalankan aplikasi setelah Firebase terinisialisasi
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Tambahkan ThemeProvider
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'XuenSun',
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Balsamiq Sans',
              scaffoldBackgroundColor: const Color.fromRGBO(248, 237, 227, 1),
              colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(26, 18, 11, 1)),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Balsamiq Sans',
              scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
              colorScheme: const ColorScheme.dark(
                primary: Color.fromRGBO(248, 237, 227, 1),
              ),
            ),
            themeMode: themeProvider.themeMode, // Mode tema
            debugShowCheckedModeBanner: false,
            home: FutureBuilder<bool>(
              future: _checkIntroSeen(), // Mengecek apakah intro sudah dilihat atau belum
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Menunggu hasil cek
                } else if (snapshot.data ?? false) {
                  // Jika sudah melihat intro, tampilkan StreamBuilder untuk cek status login
                  return StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return const Home(); // Pengguna sudah login
                      } else {
                        return const Login(); // Pengguna belum login
                      }
                    },
                  );
                } else {
                  // Jika belum melihat intro, tampilkan halaman Introduction
                  return const IntroductionPage();
                }
              },
            ),
            routes: {
              '/home': (context) => const Home(),
              '/login': (context) => const Login(), // Tambahkan route untuk login
              '/register': (context) => const Regis(),
              '/settings': (context) => const SettingsScreen(),
              '/prediksi': (context) => GeneralInputScreen(),
              '/introduction': (context) => const IntroductionPage(),
              '/about_us': (context) => const AboutUs(),
            },
          );
        },
      ),
    );
  }

  Future<bool> _checkIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('intro_seen') ?? false; // Mengecek apakah sudah melihat intro
  }
}
