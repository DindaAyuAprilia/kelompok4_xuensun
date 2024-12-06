import 'package:flutter/material.dart';

// Widget Reusable untuk Input Data
class InputFeatureWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Function(String) onChanged;

  const InputFeatureWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}