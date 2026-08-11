import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_page.dart';
import 'features/matches/matches_page.dart';
import 'features/players/players_page.dart';
import 'features/ai/ai_page.dart';
import 'features/profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Hockey Intelligence',
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MatchesPage(),
    const PlayersPage(),
    const AIPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_hockey_rounded),
            label: 'Matches',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_rounded),
            label: 'Players',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology_rounded),
            label: 'AI',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
