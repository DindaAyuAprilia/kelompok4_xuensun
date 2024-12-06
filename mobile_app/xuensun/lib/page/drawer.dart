import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("XuenSun"),
            accountEmail: Text('Siap Membantu Memahami Diri Anda'),
            decoration: BoxDecoration(
              color: Color.fromRGBO(26, 18, 11, 11),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              // Logout user menggunakan FirebaseAuth
              await FirebaseAuth.instance.signOut();

              // Kembali ke halaman login setelah logout
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info), // Icon untuk Intro
            title: const Text('Intro Screen'),
            onTap: () async {
              // Kembali ke halaman IntroductionPage
              Navigator.pushReplacementNamed(context, '/introduction');
            },
          ),
          ListTile(
            leading: const Icon(Icons.group), // Ikon untuk About Us
            title: const Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),

        ],
      ),
    );
  }
}
