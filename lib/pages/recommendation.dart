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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Small ", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
                  Text("actions", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w700, color: primary)),
                  Text(", big ", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
                  Text("impact", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w700, color: primary)),
                  Text("!", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 64.0),
                child: Text("Time to give your Eco Enzyme some treatments!", style: GoogleFonts.notoSans(fontSize: 18), textAlign: TextAlign.center,)
              )
            ),
            Expanded( // Add this
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's tasks",
                        style: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      RecommendationCard(
                        title: "Inspect for mold growth.",
                        points: 3,
                        timeAgo: "2 hours ago",
                        svgAsset: 'assets/mold.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Inspect for mold growth',
                          'points': 3,
                          'icon': 'assets/mold.svg',
                        }),
                      ),
                      const SizedBox(height: 20),
                      RecommendationCard(
                        title: "Add 2L of Clean Water.",
                        points: 5,
                        timeAgo: "6 hours ago",
                        svgAsset: 'assets/water.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Add 2L of Clean Water',
                          'points': 5,
                          'icon': 'assets/water.svg',
                        }),
                      ),
                      const SizedBox(height: 20),
                      RecommendationCard(
                        title: "Add 500gr of Brown Sugar.",
                        points: 6,
                        timeAgo: "8 hours ago",
                        svgAsset: 'assets/brown_sugar.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Add 500gr of Brown Sugar',
                          'points': 6,
                          'icon': 'assets/brown_sugar.svg',
                        }),
                      ),
                      const SizedBox(height: 20),
                      RecommendationCard(
                        title: "Check for gas buildup.",
                        points: 3,
                        timeAgo: "9 hours ago",
                        svgAsset: 'assets/gas.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Check for gas buildup',
                          'points': 3,
                          'icon': 'assets/gas.svg',
                        }),
                      ),
                      const SizedBox(height: 20),
                      RecommendationCard(
                        title: "Add fruit peels to the tank.",
                        points: 5,
                        timeAgo: "11 hours ago",
                        svgAsset: 'assets/fruit_peels.svg',
                        onTap: () => Navigator.pushNamed(context, '/filltodo', arguments: {
                          'taskTitle': 'Add fruit peels.',
                          'points': 3,
                          'icon': 'assets/fruit_peels.svg',
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a new task', // Descriptive label for accessibility
        onPressed: () {
          // Define your action, like opening a new task screen
          Navigator.pushReplacementNamed(context, '/filltodo');
        },
        backgroundColor: primary, // or use `primary` from your theme
        shape: const CircleBorder(),
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white, // transparent icon doesn't make sense visually
          size: 32,
        ),
      ),

    );
  }
}