import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    // Ambil ukuran layar perangkat
    final double deviceWidth = mediaQueryData.size.width;

    // Padding yang sesuai dengan ukuran layar
    final double horizontalPadding = deviceWidth > 600 ? 20.0 : 10.0;

    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: horizontalPadding, right: horizontalPadding),
      child: SingleChildScrollView( // Membuat widget scrollable
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: mediaQueryData.size.height-100, // Menentukan minimal tinggi
          ),
          child: child,
        ),
      ),
    );
  }
}
