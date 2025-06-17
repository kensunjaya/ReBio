import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rebio/components/AppLoadingIndicator.dart';
import 'package:rebio/theme/constants.dart';
import 'package:rebio/pages/details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/utility/firestore.dart';

const Color kDarkTextColor = Colors.black87;

class ContributorsPage extends StatefulWidget {
  const ContributorsPage({super.key});

  @override
  State<ContributorsPage> createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
  late CloudFirestoreService service;
  // Data dummy untuk para kontributor
  late List<Map<String, dynamic>> contributors;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    service = CloudFirestoreService(FirebaseFirestore.instance);
    fetchContributors();
  }

  Future<void> fetchContributors() async {
    setState(() {
      isLoading = true;
    });
    try {
      contributors = await service.fetchUsers();
    } catch (e) {
      print("Error fetching contributors: $e");
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
        body: Center(
          child: LoadingIndicator(),
        ),
      );
    }
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
          Container(
            width: 120,
            height: 120,
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
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Contributors of ",
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kDarkTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "RT.1/RW.9",
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  " eco enzyme production",
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kDarkTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ),
          const SizedBox(height: 30),

          // 2. Daftar Kontributor
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: contributors.length,
              itemBuilder: (context, index) {
                final contributor = contributors[index];
                if (contributor['profile']['contributions'] == null) {
                  return const SizedBox.shrink();
                }
                return _ContributorCard(
                  name: contributor['profile']['username'] ?? 'Unknown',
                  contribution: contributor['profile']['contributions'] ?? 0,
                  email: contributor['profile']['email'], // Email sebagai key
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
  final String? email; // acts as key to fetch the contributor's details
  final int contribution;


  const _ContributorCard({
    required this.name,
    required this.contribution,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 3,
      shadowColor: Colors.grey.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
          if (email == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No details available for $name')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                name: name,
                contribution: contribution,
                email: email!,
              ),
            ),
          );
        },
      ),
    );
  }
}