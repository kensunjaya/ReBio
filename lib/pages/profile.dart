import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/components/CustomButton.dart';
import 'package:rebio/components/UserStatisticsText.dart';
import 'package:rebio/theme/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logged out successfully! Please log in again.")),
      );
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 64.0),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_outline,
                size: 75,
                color: bg,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Username",
              style: GoogleFonts.notoSans(
                fontSize: 28, 
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "userexample.gmail.com",
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: Colors.black.withValues(alpha: 0.5),
              ) ,
            ),
            Text(
              "+62 895310410118",
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: Colors.black.withValues(alpha: 0.5),
              ) ,
            ),
            SizedBox(height: 16),
            SizedBox(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserStatisticsText(
                        label: "Total Contributions",
                        value: "12",
                        icon: Icon(Icons.group_work_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 8),
                      UserStatisticsText(
                        label: "Points earned",
                        value: "51",
                        icon: Icon(Icons.star_border_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 8),
                      UserStatisticsText(
                        label: "Unredeemed Points",
                        value: "17",
                        icon: Icon(Icons.hotel_class_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 8),
                      UserStatisticsText(
                        label: "Joined",
                        value: "10 May 2025",
                        icon: Icon(Icons.calendar_month_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 8),
                      UserStatisticsText(
                        label: "Address",
                        value: "Jl. Rw. Belong No.4, RT.1/RW.9, Kb. Jeruk, Jakarta Barat",
                        icon: Icon(Icons.home_outlined, color: Colors.grey, size: 24),
                        fontSize: 13,
                      ),
                    ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButton(text: "Log out", onPressed: () => logout(context), backgroundColor: danger)
          ],
        )
      )
    );
  }
}