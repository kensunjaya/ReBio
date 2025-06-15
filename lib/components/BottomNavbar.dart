import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/pages/home.dart';
import 'package:rebio/pages/profile.dart';
import 'package:rebio/pages/recommendation.dart';
import 'package:rebio/theme/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Recommendation(),
    const Center(child: Text("Replace this with HistoryPage() in 'components/BottomNavbar.dart'",)),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIcon(IconData iconData, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 4), // Add space only if selected
        Icon(
          iconData,
          color: isSelected ? primary : Colors.grey,
          size: 32,
        ),
        const SizedBox(height: 4),
        Container(
          height: 4,
          width: 10,
          decoration: BoxDecoration(
            color: isSelected ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: InkRipple.splashFactory,
          splashColor: primary.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: bg,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home_outlined, _selectedIndex == 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.note_alt_outlined, _selectedIndex == 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.history_outlined, _selectedIndex == 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.person_outline, _selectedIndex == 3),
              label: '',
            ),
          ],
        ),
      )
       
    );
  }
}
