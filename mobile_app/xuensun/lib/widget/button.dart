import 'package:flutter/material.dart';

// Custom Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;  // Add a variable for border color
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,  
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Ensures the button width is consistent across different pages
      height: 50, // Consistent height
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Consistent margin
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            side: BorderSide(color: borderColor, width: 2), // Set border color and width here
          ),
          // ElevatedButton shadow color can be set here if needed
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, // Consistent text styling
            color: textColor, // Set text color here
          ),
        ),
      ),
    );
  }
}
