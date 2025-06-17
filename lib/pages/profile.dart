import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/components/AppLoadingIndicator.dart';
import 'package:rebio/components/CustomButton.dart';
import 'package:rebio/components/UserStatisticsText.dart';
import 'package:rebio/theme/constants.dart';
import 'package:rebio/utility/firestore.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  late CloudFirestoreService service;
  String _username = '';
  String _email = '';
  late Map<String, dynamic>? userData = {};
  bool isLoading = true;
  late String lastContribution = 'N/A';

  @override
  void initState() {
    super.initState();
    service = CloudFirestoreService(FirebaseFirestore.instance);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      _user = FirebaseAuth.instance.currentUser;
      if (_user != null) {
        userData = await service.get('users', _user!.email.toString());
        setState(() {
          _username = userData?['profile']?['username']?.toString() ?? 'User';
          _email = _user!.email ?? 'No email';
          // Membuat huruf pertama menjadi kapital
          _username = _username.replaceRange(0, 1, _username[0].toUpperCase());
          String lastContributionRaw = userData?['profile']?['lastContribution']?.toString() ?? 'N/A';

          if (lastContributionRaw.isNotEmpty) {
            try {
              DateTime dt = DateTime.parse(lastContributionRaw);
              lastContribution = DateFormat('dd MMM yyyy').format(dt);
            } catch (e) {
              lastContribution = 'N/A';
            }
          }
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void logout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
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
    if (isLoading) {
      return Scaffold(
        backgroundColor: bg,
        body: LoadingIndicator()
      );
    }
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
              _username,
              style: GoogleFonts.notoSans(
                fontSize: 28, 
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              _email,
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
                        value: userData?['profile']?['contributions']?.toString() ?? "0",
                        icon: Icon(Icons.auto_awesome_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 16),
                      UserStatisticsText(
                        label: "Points earned",
                        value: userData?['profile']?['points']?.toString() ?? "0",
                        icon: Icon(Icons.star_border_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 16),
                      UserStatisticsText(
                        label: "Unredeemed Points",
                        value: userData?['profile']?['unredeemedPoints']?.toString() ?? "0",
                        icon: Icon(Icons.hotel_class_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 16),
                      UserStatisticsText(
                        label: "Joined",
                        value: _user?.metadata.creationTime != null
                          ? DateFormat('dd MMM yyyy').format(_user!.metadata.creationTime!.toLocal())
                          : "05 May 2025",
                        icon: Icon(Icons.calendar_month_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 16),
                      UserStatisticsText(
                        label: "Last Contribution",
                        value: lastContribution,
                        icon: Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 24),
                      ),
                      const SizedBox(height: 16),
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
            CustomButton(text: "Log out", disabled: false, onPressed: () => logout(context), backgroundColor: danger)
          ],
        )
      )
    );
  }
}