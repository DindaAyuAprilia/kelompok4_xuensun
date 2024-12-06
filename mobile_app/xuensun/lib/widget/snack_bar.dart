import 'package:flutter/material.dart';

// Kelas untuk SnackBar dengan tombol X untuk menutup
class CustomSnackBar {
  // Make show method static to be accessible directly without an instance.
  static SnackBar show(BuildContext context, String message) {
    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'X',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}
