import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/theme/constants.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String points;
  final String timeAgo;
  final String svgAsset;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.points,
    required this.timeAgo,
    required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.notoSans(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          points,
                          style: GoogleFonts.notoSans(fontSize: 16, color: yellowPoint),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        timeAgo,
                        style: GoogleFonts.notoSans(fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                svgAsset,
                colorFilter: ColorFilter.mode(
                  primary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}