import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/theme/constants.dart';
import 'dart:math';

class LoadingIndicator extends StatelessWidget {
  final double fontSize;
  final Color? textColor;
  final Color? indicatorColor;
  static const List<String> loadingMessages = [
    "Loading green stats..",
    "Waking up ReBio..",
    "Brewing eco info..",
    "Tending your garden..",
    "Loading footprint..",
    "Stirring enzymes..",
    "Gathering insights..",
    "Harvesting data..",
    "Compiling eco stats..",
    "Syncing with nature..",
    "Preparing your eco journey..",
    "Loading your green impact..",
  ];

  LoadingIndicator({
    Key? key,
    this.fontSize = 20,
    this.textColor,
    this.indicatorColor = primary,
  })  : message = loadingMessages[Random().nextInt(loadingMessages.length)],
        super(key: key);

  final String message;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              message,
              style: GoogleFonts.notoSans(
                fontSize: fontSize,
                color: textColor ?? secondary,
              ),
            ),
          ),
          CircularProgressIndicator(
            color: indicatorColor,
          ),
        ],
      ),
    );
  }
}
