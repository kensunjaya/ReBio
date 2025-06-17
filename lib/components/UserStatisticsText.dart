import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserStatisticsText extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final Color textColor;
  final Widget icon;

  const UserStatisticsText({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.fontSize = 14,
    this.textColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        const SizedBox(width: 16),
        Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const Spacer(),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            value,
            style: GoogleFonts.notoSans(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
