import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk registrasi pengguna baru
  Future<void> regis(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Email sudah terdaftar. Silakan gunakan email lain.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Format email tidak valid. Periksa kembali email Anda.');
      } else if (e.code == 'weak-password') {
        throw Exception('Password terlalu lemah. Gunakan minimal 6 karakter.');
      } else {
        throw Exception('Terjadi kesalahan yang tidak diketahui: ${e.message}');
      }
    }
  }


  // Fungsi untuk login pengguna
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Pengguna tidak ditemukan. Silakan registrasi.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Password salah.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Format email tidak valid.');
      } else {
        throw Exception('Pastikan password dan email yang dimasukan benar.');
      }
    }
  }
}
