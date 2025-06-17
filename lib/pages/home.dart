import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rebio/components/AppLoadingIndicator.dart';
import 'package:rebio/utility/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/pages/contributors.dart';
import 'package:rebio/theme/constants.dart';
const Color kGreyTextColor = Colors.grey;
const Color kDarkTextColor = Colors.black87;


class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  late CloudFirestoreService service;
  String _username = '';
  bool isLoading = true;
  late Map<String, dynamic>? userData = {};
  late String greetingMessage;

  @override
  void initState() {
    super.initState();
    service = CloudFirestoreService(FirebaseFirestore.instance);
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingMessage = 'Good Morning';
    } else if (hour < 18) {
      greetingMessage = 'Good Afternoon';
    } else {
      greetingMessage = 'Good Evening';
    }
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      _user = FirebaseAuth.instance.currentUser;
      if (_user != null) {
        userData = await service.get('users', _user!.email.toString());
        setState(() {
          _username = userData?['profile']?['username']?.toString() ?? 'User';
          // Membuat huruf pertama menjadi kapital
          if (_username.isNotEmpty) {
            _username = '$_username!'.replaceRange(0, 1, _username[0].toUpperCase());
          }
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false; // Set loading ke false setelah data diambil
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: LoadingIndicator()
      );
    }
    return Scaffold(
      backgroundColor: bg, // Menggunakan warna dari konstanta
      body: SafeArea(
        child: Stack( // Gunakan Stack untuk menumpuk tombol logout di atas konten
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), 

                  // 1. Teks Sambutan (Header)
                  _buildHeader(),
                  const SizedBox(height: 20),

                  // 2. Kartu Kondisi Utama
                  _buildHealthyCard(),
                  const SizedBox(height: 20),

                  // 3. Tombol Lihat Kontributor
                  _buildContributorsButton(context),
                  const SizedBox(height: 20),

                  // 4. Kartu Info (Waktu & Progres)
                  _buildInfoCard(
                    icon: Icons.timer_outlined,
                    label: 'Time elapsed',
                    value: '33 days',
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard(
                    icon: Icons.pie_chart_outline_rounded,
                    label: 'Progress',
                    value: '21%',
                  ),
                  const SizedBox(height: 20),
                  
                  // 5. Kartu Lokasi
                  _buildLocationCard(),
                  const SizedBox(height: 20),

                  // 6. Baris Info Temperatur dan pH
                  _buildMeasurementRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk header "Greeting, Username!"
  Widget _buildHeader() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.notoSans(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: kDarkTextColor,
        ),
        children: [
          TextSpan(
            text: '$greetingMessage,\n', 
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kDarkTextColor, // Menggunakan warna abu-abu untuk teks sapaan
            )
          ),
          TextSpan(
            text: _username,
            style: GoogleFonts.notoSans(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: primary, // Menggunakan warna primer dari tema
            )
          ),
        ],
      ),
    );
  }

  Widget _buildHealthyCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          )
        ]
      ),
      // Gunakan Column sebagai widget utama untuk menyusun elemen secara vertikal
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris pertama untuk judul dan gambar
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom untuk teks judul
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eco Enzyme condition',
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kGreyTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Healthy',
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Gambar tetap di sini
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ecoenzyme.png', // Ganti dengan path gambar yang sesuai
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Spasi antara bagian atas dan deskripsi
          // Teks deskripsi sekarang berada di bawah Row, sehingga bisa membentang penuh
          Text(
            'Currently, EcoEnzyme is in active fermentation phase, characterized by the appearance of gas bubbles that occasionally rise to the surface. A fresh sour smell also began to emanate, indicating that the process of transforming organic waste into a multipurpose liquid is proceeding as it should.',
            textAlign: TextAlign.justify,
            style: GoogleFonts.notoSans(
              fontSize: 12,
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol "View all contributors"
   Widget _buildContributorsButton(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      elevation: 4.0,
      shadowColor: Colors.grey.withValues(alpha: 0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContributorsPage()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'View all contributors',
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kDarkTextColor,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: kGreyTextColor),
            ],
          ),
        ),
      ),
    );
  }


  // Template kartu untuk info (Waktu, Progres)
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.notoSans(fontSize: 14, color: kGreyTextColor),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kDarkTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget khusus untuk kartu lokasi
  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.black54, size: 30),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: GoogleFonts.notoSans(fontSize: 14, color: kGreyTextColor),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jl. Rw. Belong, RT.1/RW.9, Kb. Jeruk, Jakarta Barat',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kDarkTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk baris yang berisi info temperatur dan pH
  Widget _buildMeasurementRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMeasurementCard(
            icon: Icons.thermostat_rounded,
            value: '24° C',
            iconColor: Colors.orange,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildMeasurementCard(
            icon: Icons.science_outlined,
            value: '3.5 pH',
            iconColor: Colors.blue,
          ),
        ),
      ],
    );
  }

  // Template untuk kartu kecil (Temperatur dan pH)
  Widget _buildMeasurementCard({
    required IconData icon,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Text(
            value,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kDarkTextColor,
            ),
          ),
        ],
      ),
    );
  }
}