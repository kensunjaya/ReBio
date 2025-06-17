import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rebio/theme/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebio/utility/firestore.dart';
import 'package:intl/intl.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  User? _user;
  late CloudFirestoreService service;
  late List contributions = [];
  late Map<String, dynamic>? locationData = {};
  Map<String, List<Map<String, dynamic>>> groupedContributions = {};

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
        locationData = await service.get('locations', '1a');
        List<dynamic> rawContributions = locationData!['contributions'] ?? [];

        for (var item in rawContributions) {
          if (item['timestamp'] == null) continue;

          Timestamp ts = item['timestamp'];
          DateTime date = ts.toDate();

          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final itemDate = DateTime(date.year, date.month, date.day);
          final diff = today.difference(itemDate).inDays;

          String key;
          if (diff == 0) {
            key = 'Today';
          } else if (diff == 1) {
            key = 'Yesterday';
          } else {
            key = DateFormat('d MMMM yyyy').format(itemDate);
          }

          if (!groupedContributions.containsKey(key)) {
            groupedContributions[key] = [];
          }

          groupedContributions[key]!.add(item);
        }

        setState(() {});
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print("Error fetching location data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(context),
            Expanded(child: _buildHistoryList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "History",
            style: GoogleFonts.notoSans(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            "Thank you for participating in sustainable waste management with ReBio!",
            style: GoogleFonts.notoSans(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    final sortedKeys = groupedContributions.keys.toList()
      ..sort((a, b) {
        if (a == 'Today') return -1;
        if (b == 'Today') return 1;
        if (a == 'Yesterday') return -1;
        if (b == 'Yesterday') return 1;

        final format = DateFormat('d MMMM yyyy');
        final dateA = format.parse(a);
        final dateB = format.parse(b);
        return dateB.compareTo(dateA); // descending
      });

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      children: sortedKeys.expand((dateKey) {
        final items = groupedContributions[dateKey]!;
        return [
          _buildDateSection(dateKey),
          ...items.map((contribution) => _buildHistoryCard(
                svgAsset: contribution['icon'] ?? 'assets/icons/default.svg',
                title: contribution['title'] ?? 'Unknown Title',
                description: contribution['details'] ?? 'No description available.',
                name: contribution['username'] ?? 'Anonymous',
              )),
        ];
      }).toList(),
    );
  }

  Widget _buildDateSection(String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
      child: Text(
        date,
        style: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildHistoryCard({
    required String svgAsset,
    required String title,
    required String description,
    required String name,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(svgAsset, width: 30, height: 30),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(description, style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black.withValues(alpha: 0.5)), textAlign: TextAlign.start),
            const SizedBox(height: 5),
            Row(
              children: [
                Spacer(),
                const Icon(Icons.person, color: primary),
                const SizedBox(width: 4),
                Text(name, style: GoogleFonts.notoSans(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}