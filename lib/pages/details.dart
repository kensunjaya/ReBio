import 'package:flutter/material.dart';
import 'package:rebio/theme/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kDarkTextColor = Colors.black87;

class DetailsPage extends StatelessWidget {
  final String name;
  final int contribution;

  const DetailsPage({
    super.key,
    required this.name,
    required this.contribution,
  });

  @override
  Widget build(BuildContext context) {
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
                name, // <-- Gunakan data dari constructor
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
                      value: contribution.toString(), // <-- Gunakan data dari constructor
                    ),
                    _buildInfoRow(
                      icon: Icons.star_border_rounded,
                      label: 'Points Earned',
                      value: '18', // (Data masih statis)
                    ),
                    _buildInfoRow(
                      icon: Icons.brightness_high_outlined,
                      label: 'Unredeemed Points',
                      value: '7', // (Data masih statis)
                    ),
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Last Contribution',
                      value: 'Yesterday', // (Data masih statis)
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