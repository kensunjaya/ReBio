import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rebio/components/AppLoadingIndicator.dart';
import 'package:rebio/theme/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/utility/firestore.dart';
import 'package:intl/intl.dart';

const Color kDarkTextColor = Colors.black87;

class DetailsPage extends StatefulWidget {
  final String name;
  final int contribution;
  final String email;

  const DetailsPage({
    super.key,
    required this.name,
    required this.contribution,
    required this.email,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late CloudFirestoreService service;
  bool isLoading = true;
  late Map<String, dynamic>? userData = {};
  late String _username;
  late String totalContributions;
  late String points;
  late String unredeemedPoints;
  late String lastContribution;

  @override
  void initState() {
    super.initState();
    service = CloudFirestoreService(FirebaseFirestore.instance);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      userData = await service.get('users', widget.email);
      setState(() {
        _username = userData?['profile']?['username']?.toString() ?? 'User';
        totalContributions = userData?['profile']?['contributions']?.toString() ?? '0';
        points = userData?['profile']?['points']?.toString() ?? '0';
        unredeemedPoints = userData?['profile']?['unredeemedPoints']?.toString() ?? '0';
        String lastContributionRaw = userData?['profile']?['lastContribution']?.toString() ?? 'N/A';
        lastContribution = 'N/A';

        if (lastContributionRaw.isNotEmpty) {
          try {
            DateTime dt = DateTime.parse(lastContributionRaw);
            lastContribution = DateFormat('dd MMM yyyy').format(dt);
          } catch (e) {
            lastContribution = 'N/A';
          }
        }
      });
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
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
      appBar: AppBar(
        // AppBar dibuat transparan agar menyatu dengan body
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // 1. Avatar Pengguna
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color:  Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              // 2. Nama Pengguna
               Text(
                _username, // <-- Gunakan data dari constructor
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kDarkTextColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '+62 895310410118',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // 3. Kartu Informasi
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color:  Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.auto_awesome_outlined,
                      label: 'Total Contributions',
                      value: totalContributions, // <-- Gunakan data dari constructor
                    ),
                    _buildInfoRow(
                      icon: Icons.star_border_rounded,
                      label: 'Points Earned',
                      value: points, // (Data masih statis)
                    ),
                    _buildInfoRow(
                      icon: Icons.hotel_class_outlined,
                      label: 'Unredeemed Points',
                      value: unredeemedPoints, // (Data masih statis)
                    ),
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Last Contribution',
                      value: lastContribution, // (Data masih statis)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget helper untuk membuat setiap baris info di dalam kartu
  /// agar kode tidak berulang.
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 22),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
          const Spacer(), // Mendorong widget berikutnya ke kanan
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}