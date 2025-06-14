import 'package:flutter/material.dart';
import 'package:rebio/theme/constants.dart';
import 'package:rebio/pages/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kDarkTextColor = Colors.black87;

class ContributorsPage extends StatelessWidget {
  const ContributorsPage({super.key});

  // Data dummy untuk para kontributor
  // Anda bisa mengganti ini dengan data dari database (misal: Firestore)
  final List<Map<String, dynamic>> contributors = const [
    {'name': 'John Doe', 'contribution': 5},
    {'name': 'Quinn Park', 'contribution': 12},
    {'name': 'Elliot Rivera', 'contribution': 8},
    {'name': 'Casey Blake', 'contribution': 11},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        // Menghilangkan judul dari AppBar
        backgroundColor: bg,
        elevation: 0, // Menghilangkan bayangan di bawah AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kDarkTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // 1. Bagian Header (Logo dan Judul)
          CircleAvatar(
            radius: 55, // Ukuran total lingkaran
            backgroundColor: primary.withOpacity(0.4), // Warna latar belakang/bingkai
            child: ClipOval( // Memastikan gambar di dalamnya juga berbentuk lingkaran
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Beri jarak 10 poin di sekeliling gambar
                child: Image.asset(
                  'assets/images/ecoenzyme.png',
                  fit: BoxFit.cover, // Memastikan gambar mengisi ruang yang lebih kecil
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "RT.1/RW.9's Ecoenzym",
            style: GoogleFonts.notoSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kDarkTextColor,
            ),
          ),
          const SizedBox(height: 30),

          // 2. Daftar Kontributor
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: contributors.length,
              itemBuilder: (context, index) {
                final contributor = contributors[index];
                return _ContributorCard(
                  name: contributor['name'],
                  contribution: contributor['contribution'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget privat untuk setiap kartu kontributor agar kode lebih rapi
class _ContributorCard extends StatelessWidget {
  final String name;
  final int contribution;

  const _ContributorCard({
    required this.name,
    required this.contribution,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 3,
      shadowColor: Colors.grey.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFEEEEEE),
          child: Icon(
            Icons.person,
            color: Color(0xFFBDBDBD),
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            color: kDarkTextColor,
          ),
        ),
        subtitle: Text(
          'Contribution: $contribution',
          style: GoogleFonts.notoSans(),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                name: name,
                contribution: contribution,
              ),
            ),
          );
        },
      ),
    );
  }
}