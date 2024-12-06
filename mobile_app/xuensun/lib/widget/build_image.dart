import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final String assetName;
  final double height;
  const ImageBuilder({
    Key? key,
    required this.assetName,
    this.height = 200.0, // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Use a fixed height for consistency
      alignment: Alignment.center,
      child: Image.asset('assets/$assetName', fit: BoxFit.fitWidth),
    );
  }
}
