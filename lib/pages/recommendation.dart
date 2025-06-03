import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 64.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text("Hello, Username!", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 64.0, right: 64.0),
                  child: Text("Time to give your Eco Enzyme some care!", style: GoogleFonts.notoSans(fontSize: 18), textAlign: TextAlign.center,)
                )
              ),
              Column(
                children: [
                  
                ]
              )
            ]
          )
        )
      ),
    );
  }
}