import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sihapp/appscreens/Home.dart';
import 'package:sihapp/appscreens/analysis.dart';

import '../appscreens/leaderboard.dart';
import '../charts/bmicharts.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  // List of pages (all full Scaffold)
  final List<Widget> _pages = [
    Home(),
    AthletePerformanceScreen(),
    PerformancePage(),
    LeaderboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex], // Show selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF39D2C0),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.upcoming), label: "Strength"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions), label: "Performance"),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "Rank"),
        ],
      ),
    );
  }
}
