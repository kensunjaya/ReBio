import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/theme/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double fontSize;
  final bool disabled;
  final double verticalPadding;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.disabled,
    required this.onPressed,
    this.backgroundColor = primary,
    this.fontSize = 18,
    this.verticalPadding = 16.0,
    this.borderRadius = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed, // Disable button if disabled is true
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled
              ? Colors.grey // Use grey when disabled
              : backgroundColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.notoSans(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}