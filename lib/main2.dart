// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_6/upcoming_events_page.dart..dart';

// Clean imports
import 'upcoming_events_page.dart';
import 'history_page.dart';
import 'match_fixtures_page.dart';
import 'highlights_page.dart';
import 'match_rules_page.dart';
import 'contact_page.dart';
import 'settings_page.dart';
import 'join_club_page.dart';
import 'login_page.dart';
import 'add_team_page.dart';
import 'search_team_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00B4D8), // Electric blue
          background: const Color(0xFF0A1929), // Deep navy
          surface: const Color(0xFF0F263A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A1929),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: MainScreen(),
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

  // Player data (unchanged)
  final List<Map<String, dynamic>> players = [
    // ... your player list
  ];

  void onItemPressed(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTeamPage()),
      );
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
          color: const Color(0xFF0F263A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF00B4D8), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.signal_cellular_alt,
                color: const Color(0xFF00B4D8),
                size: 40,
              ),
              const SizedBox(height: 16),
              Text(
                "Live Streaming\nComing Soon!",
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: Navigator.of(context).pop,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayersList() {
    if (players.isEmpty) return const Center(child: Text('No players.'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: const Color(0xFF142B42),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: player['image'] != null
                      ? AssetImage(player['image'])
                      : null,
                  backgroundColor: Colors.grey[800],
                  child: player['image'] == null
                      ? Text(
                          player['jerseyNumber'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player['name'],
                        style: GoogleFonts.orbitron(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B4D8).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          player['position'],
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF00B4D8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Age: ${player['age']} | Jersey: ${player['jerseyNumber']}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F263A),
        title: Text(
          "Confirm Logout",
          style: GoogleFonts.orbitron(color: Colors.white),
        ),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1929),
      appBar: AppBar(
        title: Text(
          "My Team Hockey",
          style: GoogleFonts.orbitron(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _selectedIndex = 1),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background pattern (optional: add asset or use Container)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A1929), Color(0xFF0C2035)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          if (_selectedIndex == 0) ...[
            // Live Score Pulse
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                decoration: BoxDecoration(
                  color: const Color(0xFF142B42),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF00B4D8),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00B4D8).withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPulseLiveIndicator(),
                    _buildTeam("PPG", Colors.orange),
                    const Text(
                      "3 - 2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildTeam("TIGERS", Colors.blue),
                    _buildPeriod("2nd", "PERIOD"),
                  ],
                ),
              ),
            ),

            // Login/Register
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (_selectedIndex == 1) const SearchTeamPage(),
          if (_selectedIndex == 3) _buildPlayersList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showBottom,
        backgroundColor: Colors.red,
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(
        backgroundColor: const Color(0xFF0F263A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0A1929),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/hockey_rink_pattern.png",
                  ), // Optional
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: const AssetImage(
                      "assets/images/download.jpeg",
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Bala Ganesh V.",
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "balahockey@123gmail.com",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            ..._buildDrawerItems(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: onItemPressed,
        backgroundColor: const Color(0xFF0A1929),
        height: 68,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Add'),
          NavigationDestination(icon: Icon(Icons.group), label: 'Players'),
        ],
        indicatorColor: const Color(0xFF00B4D8),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildPulseLiveIndicator() {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.8),
                blurRadius: 12,
                spreadRadius: 3,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "LIVE",
          style: GoogleFonts.orbitron(
            color: Colors.red,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTeam(String name, Color color) => Column(
    children: [
      Text(
        name,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const Text("Team", style: TextStyle(color: Colors.white70, fontSize: 10)),
    ],
  );

  Widget _buildPeriod(String period, String label) => Column(
    children: [
      Text(
        period,
        style: const TextStyle(
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
    ],
  );

  List<Widget> _buildDrawerItems() {
    final items = [
      ("Upcoming Events", Icons.emoji_events_outlined, UpcomingEventsPage()),
      ("History", Icons.history, MatchHistoryPage()),
      ("Highlights", Icons.live_tv, HighlightsPage()),
      ("Fixtures", Icons.date_range, MatchFixturesPage()),
      ("Live", Icons.play_circle, null),
      ("Rules", Icons.rule, MatchRulesPage()),
      ("Contact", Icons.phone, ContactPage()),
      ("Join Club", Icons.people, JoinClubPage()),
      ("Settings", Icons.settings, SettingsPage()),
    ];

    return items.expand((item) sync* {
      yield ListTile(
        leading: Icon(item.$2, color: const Color(0xFF00B4D8)),
        title: Text(
          item.$1,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        onTap: () {
          Navigator.pop(context);
          if (item.$1 == "Live") {
            showBottom();
          } else if (item.$3 != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.$3!),
            );
          }
        },
      );
      yield const Divider(height: 1, color: Colors.grey);
    }).toList();
  }
}
