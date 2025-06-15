import 'package:flutter/material.dart';
import 'package:rebio/theme/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            const SizedBox(height: 16),
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
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      children: [
        _buildDateSection('15 May'),
        _buildHistoryCard(
          svgAsset: 'assets/mold.svg',
          title: 'Inspect for mold growth.',
          description:
              'Contributed to maintaining a healthy fermentation process by checking for contamination.',
          name: 'Sedyawati',
        ),
        _buildHistoryCard(
          svgAsset: 'assets/brown_sugar.svg',
          title: 'Add 200gr of Brown Sugar.',
          description:
              'Fed the beneficial microbes with a sugar source to support fermentation.',
          name: 'Sunjaya',
        ),
        _buildHistoryCard(
          svgAsset: 'assets/mold.svg',
          title: 'Donated 1.5 kg of fruit peels.',
          description:
              'Contributed organic waste to support sustainable enzyme production and reduce landfill load.',
          name: 'Oktavia',
        ),
        const SizedBox(height: 20),
        _buildDateSection('Yesterday'),
        _buildHistoryCard(
          svgAsset: 'assets/gas.svg',
          title: 'Checked for gas buildup.',
          description:
              'Released excess pressure to prevent container damage and ensure safety.',
          name: 'Pak Budi',
        ),
        _buildHistoryCard(
          svgAsset: 'assets/mold.svg',
          title: 'Collected dry leaves from garden.',
          description:
              'Helped balance the carbon-nitrogen ratio for optimal fermentation.',
          name: 'Sintia',
        ),
      ],
    );
  }

  Widget _buildDateSection(String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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