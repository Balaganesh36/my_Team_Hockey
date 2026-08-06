import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_page.dart';
import 'features/matches/matches_page.dart';
import 'features/players/players_page.dart';
import 'features/videos/highlights_page.dart';
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
      title: 'My Team Hockey',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default to dark for premium look
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
    const HighlightsPage(),
    const PlayersPage(),
    const ProfilePage(),
  ];

  final List<String> _titles = [
    "HOME",
    "MATCHES",
    "HIGHLIGHTS",
    "PLAYERS",
    "PROFILE",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_selectedIndex == 3)
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        height: 80,
        elevation: 10,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF1565C0)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events, color: Color(0xFF1565C0)),
            label: 'Matches',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            selectedIcon: Icon(Icons.play_circle, color: Color(0xFF1565C0)),
            label: 'Videos',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group, color: Color(0xFF1565C0)),
            label: 'Players',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF1565C0)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
