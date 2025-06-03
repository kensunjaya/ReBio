import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    SizedBox(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(
                                alpha: 0.5,
                              ),
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
                                        "Inspect for mold growth.",
                                        style: GoogleFonts.notoSans(fontSize: 16),
                                        textAlign: TextAlign.left,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "+3",
                                          style: GoogleFonts.notoSans(fontSize: 16, color: yellowPoint),
                                        )
                                      )
                                      
                                    ]
                                  ),
                                  
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        "2 hours ago",
                                        style: GoogleFonts.notoSans(fontSize: 14),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/mold.svg',
                                colorFilter: ColorFilter.mode(
                                  primary,
                                  BlendMode.srcIn,
                                )
                              ),
                            ]
                          )
                        ),
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      ),
    );
  }
}