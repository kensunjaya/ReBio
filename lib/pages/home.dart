//   // ini buat sementara aja log out nya ditaro di home page, later bakal dipindahin ke Profile Page kalo udah ada Profile Page.
//   void logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, '/login');
//   }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String _username = 'User!'; // Default username

  @override
  // void initState() {
  //   super.initState();
  //   _user = FirebaseAuth.instance.currentUser;
  //   // Ambil display name, jika tidak ada, gunakan email, jika tidak ada juga, gunakan default.
  //   _username = _user?.displayName ?? _user?.email?.split('@')[0] ?? 'Username';
  //   // Membuat huruf pertama menjadi kapital
  //   _username = '$_username!'.replaceRange(0, 1, _username![0].toUpperCase());
  // }

  // Fungsi logout yang sudah ada
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Pastikan Anda memiliki route '/login' di main.dart
    if (mounted) {
       Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg, // Menggunakan warna dari konstanta
      body: SafeArea(
        child: Stack( // Gunakan Stack untuk menumpuk tombol logout di atas konten
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer untuk memberi ruang bagi tombol logout
                  const SizedBox(height: 40), 

                  // 1. Teks Sambutan (Header)
                  _buildHeader(),
                  const SizedBox(height: 24),

                  // 2. Kartu Kondisi Utama
                  _buildHealthyCard(),
                  const SizedBox(height: 16),

                  // 3. Tombol Lihat Kontributor
                  _buildContributorsButton(context),
                  const SizedBox(height: 20),

                  // 4. Kartu Info (Waktu & Progres)
                  _buildInfoCard(
                    icon: Icons.timer_outlined,
                    label: 'Time elapsed',
                    value: '33 days',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.pie_chart_outline_rounded,
                    label: 'Progress',
                    value: '21%',
                  ),
                  const SizedBox(height: 16),
                  
                  // 5. Kartu Lokasi
                  _buildLocationCard(),
                  const SizedBox(height: 20),

                  // 6. Baris Info Temperatur dan pH
                  _buildMeasurementRow(),
                ],
              ),
            ),
            // Tombol Logout di pojok kanan atas
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.logout, color: kDarkTextColor),
                onPressed: () => logout(context),
                tooltip: 'Logout',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk header "Hello, Username!"
  Widget _buildHeader() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.notoSans(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: kDarkTextColor,
        ),
        children: [
          const TextSpan(text: 'Hello, '),
          TextSpan(
            text: "Username",
            style: const TextStyle(color: primary),
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
        borderRadius: BorderRadius.circular(24.0),
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
                  color: primary.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/ecoenzyme.png',
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image_rounded,
                        color: secondary,
                        size: 40,
                      );
                    },
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
              fontSize: 10,
              color: kDarkTextColor,
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
      borderRadius: BorderRadius.circular(15.0),
      elevation: 4.0,
      shadowColor: Colors.grey.withValues(alpha: 0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
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
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
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
                  fontWeight: FontWeight.w700,
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
        borderRadius: BorderRadius.circular(15.0),
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
                  fontWeight: FontWeight.bold,
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
        borderRadius: BorderRadius.circular(15.0),
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
                    fontWeight: FontWeight.bold,
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
        const SizedBox(width: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
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
              fontWeight: FontWeight.bold,
              color: kDarkTextColor,
            ),
          ),
        ],
      ),
    );
  }
}