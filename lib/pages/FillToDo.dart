import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/theme/constants.dart';

class Filltodo extends StatefulWidget {
  const Filltodo({super.key});

  @override
  State<Filltodo> createState() => _FilltodoState();
}

class _FilltodoState extends State<Filltodo> {
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
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text("Made an impact today?", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 64.0, right: 64.0),
                  child: Text("Let's take a minute to tell others what you contributed!", style: GoogleFonts.notoSans(fontSize: 18), textAlign: TextAlign.center,)
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    SizedBox(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "What did you do today?",
                              hintStyle: GoogleFonts.notoSans(fontSize: 16, color: Colors.grey)
                            ),
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