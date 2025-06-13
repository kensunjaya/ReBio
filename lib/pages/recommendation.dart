import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/components/RecommendationCard.dart';
import 'package:rebio/theme/constants.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Padding(
        padding: EdgeInsets.only(top: 64.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Hello, Username!", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: EdgeInsets.only(left: 64.0, right: 64.0),
                child: Text("Time to give your Eco Enzyme some care!", style: GoogleFonts.notoSans(fontSize: 18), textAlign: TextAlign.center,)
              )
            ),
            Expanded( // Add this
              child: Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today",
                        style: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      RecommendationCard(
                        title: "Inspect for mold growth.",
                        points: 3,
                        timeAgo: "2 hours ago",
                        svgAsset: 'assets/mold.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Inspect for mold growth',
                          'points': 3,
                        }),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      RecommendationCard(
                        title: "Add 2L of Clean Water.",
                        points: 5,
                        timeAgo: "6 hours ago",
                        svgAsset: 'assets/water.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Add 2L of Clean Water',
                          'points': 5,
                        }),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      RecommendationCard(
                        title: "Add 500gr of Brown Sugar.",
                        points: 6,
                        timeAgo: "8 hours ago",
                        svgAsset: 'assets/brown_sugar.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Add 500gr of Brown Sugar',
                          'points': 6,
                        }),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      RecommendationCard(
                        title: "Check for gas buildup.",
                        points: 3,
                        timeAgo: "12 hours ago",
                        svgAsset: 'assets/gas.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Check for gas buildup',
                          'points': 3,
                        }),
                      )
                    ]
                  ),
                ),
              ),
            ),
          ]
        ),
      ),

    );
  }
}