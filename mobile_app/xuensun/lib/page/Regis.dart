import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:xuensun/controller/auth.dart'; // Sesuaikan import sesuai dengan lokasi class Auth

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  // Method handleSubmit yang akan menangani registrasi
  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.text;
    final password = _ctrlPassword.text;

    setState(() => _loading = true); // Tampilkan loading indicator

    try {
      await Auth().regis(email, password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi Berhasil!')),
      );

      // Pindah ke halaman Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );

    } finally {
      setState(() => _loading = false); // Sembunyikan loading indicator setelah proses selesai
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextFormField(
                  controller: _ctrlEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Email Anda';
                    }
                    // Validasi format email menggunakan regex
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),

                SizedBox(height: 10),
                TextFormField(
                  controller: _ctrlPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Password Anda';
                    } else if (value.length < 6) {
                      return 'Password harus minimal 6 karakter';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => handleSubmit(),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text("Submit"),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Sudah Punya Akun? Klik Disini Untuk Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
