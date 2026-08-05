// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_6/upcoming_events_page.dart..dart';
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
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Sample player data
  List<Map<String, dynamic>> players = [
    {
      'name': 'Akshay(Captain)',
      'jerseyNumber': 16,
      'position': 'Defender',
      'age': 22,
      'bio': 'Solid defender, Known for strong tackles and leadership!!',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.10.04_690a20a6.jpg",
    },
    {
      'name': 'Bala',
      'jerseyNumber': 14,
      'position': 'Right Off',
      'age': 19,
      'bio':
          'Versatile center who contributes on both offense and defense. Strong face-off winner and plays a smart, two-way game.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 11.52.53_072bebbe.jpg",
    },
    {
      'name': 'Selvam',
      'jerseyNumber': 1,
      'position': 'Goalkeeper',
      'age': 22,
      'bio': 'Reliable goalkeeper with quick reflexes.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.11.55_3b190d7b.jpg",
    },
    {
      'name': 'Bharathi dhasan',
      'jerseyNumber': 6,
      'position': 'Forward',
      'age': 19,
      'bio':
          'Fast and skilled forward with a powerful shot. Creates scoring chances and applies strong pressure.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 11.52.53_66396314.jpg",
    },
    {
      'name': 'Bharathi kanan',
      'jerseyNumber': 5,
      'position': 'Forward',
      'age': 19,
      'bio': 'Agile attacker known for quick breaks and accurate finishing.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 11.52.53_84000915.jpg",
    },
    {
      'name': 'Dhiwakar',
      'jerseyNumber': 8,
      'position': 'Defenseman',
      'age': 22,
      'bio': 'Reliable last line of defense with quick reflexes and composure.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.13.27_4f3d50c1.jpg",
    },
    {
      'name': 'Thava Vishwa',
      'jerseyNumber': 3,
      'position': 'Forward',
      'age': 21,
      'bio': 'Fast and agile forward with a powerful shot.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.15.15_04bfdb71.jpg",
    },
    {
      'name': 'Anand',
      'jerseyNumber': 24,
      'position': 'Left Off',
      'age': 21,
      'bio':
          'Hard-working midfielder who links defense and attack effectively.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.16.53_1db071d3.jpg",
    },
    {
      'name': 'Vigneshwarn',
      'jerseyNumber': 11,
      'position': 'Defenseman',
      'age': 22,
      'bio':
          'Reliable defenseman who excels at blocking shots and starting plays from the back.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.16.53_772a44e7.jpg",
    },
    {
      'name': 'Arunraj',
      'jerseyNumber': 18,
      'position': 'Forward',
      'age': 18,
      'bio': 'Fast and agile forward with a powerful shot.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.23.44_b0647740.jpg",
    },
    {
      'name': 'Gowtham',
      'jerseyNumber': 46,
      'position': 'Defenseman',
      'age': 20,
      'bio':
          'Stalwart defender who shuts down attackers and starts counter-attacks.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.16.54_a3f57636.jpg",
    },
    {
      'name': 'Abinesh',
      'jerseyNumber': 2,
      'position': 'Left off',
      'age': 20,
      'bio':
          'Hard-working midfielder who links defense and attack effectively.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.42.06_512c4d63.jpg",
    },
    {
      'name': 'Krithick',
      'jerseyNumber': 1,
      'position': 'Goalkeeper',
      'age': 22,
      'bio': 'Reliable goalkeeper with quick reflexes.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.42.14_3775dfae.jpg",
    },
    {
      'name': 'Selvaganapathy',
      'jerseyNumber': 10,
      'position': 'Forward',
      'age': 18,
      'bio': 'Agile attacker known for quick breaks and accurate finishing.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.44.20_2a002fa7.jpg",
    },
    {
      'name': 'Dhineshkumar',
      'jerseyNumber': 20,
      'position': 'Forward',
      'age': 20,
      'bio': 'Fast and agile forward with a powerful shot.',
      "image":
          "assets/images/WhatsApp Image 2025-07-24 at 12.46.09_9c078f15.jpg",
    },
  ];

  void onItemPressed(int index) {
    if (index == 2) {
      // Open Add Team Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTeamPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Live Streaming Coming Soon!"),
              TextButton(
                child: Icon(Icons.cancel_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayersList() {
    if (players.isEmpty) {
      return Center(child: Text('No players added yet.'));
    }

    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4.0,
          child: ExpansionTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: player['image'] != null
                  ? AssetImage(player['image'])
                  : null,
              backgroundColor: player['image'] != null
                  ? Colors.transparent
                  : Colors.grey[300],
              child: player['image'] == null
                  ? Text(
                      player['jerseyNumber'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  : null,
            ),
            title: Text(
              player['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(player['position']),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jersey Number: ${player['jerseyNumber']}'),
                    SizedBox(height: 8),
                    Text('Position: ${player['position']}'),
                    SizedBox(height: 8),
                    Text('Age: ${player['age']}'),
                    SizedBox(height: 8),
                    Text('Bio: ${player['bio']}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Logout Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8),
            Text("Confirm Logout"),
          ],
        ),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Cancel
            },
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Team Hockey"),
        titleTextStyle: GoogleFonts.oldenburg(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          // 🔍 Search Icon
          IconButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
          // ⋮ More Options: Settings & Logout
          IconButton(
            onPressed: () async {
              final selected = await showMenu(
                context: context,
                position: RelativeRect.fromRect(
                  Rect.fromPoints(
                    Offset(300, kToolbarHeight + 10),
                    Offset(350, kToolbarHeight + 50),
                  ),
                  Offset.zero & MediaQuery.of(context).size,
                ),
                items: [
                  PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 18, color: Colors.blue),
                        SizedBox(width: 10),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 18, color: Colors.red),
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
              );

              if (selected == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              } else if (selected == 'logout') {
                _showLogoutDialog(context);
              }
            },
            icon: Icon(Icons.more_vert),
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          // 🏠 Home Tab: Background Image
          if (_selectedIndex == 0)
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/0d449779-543a-45dd-8917-2851183908a4.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: OverflowBar(
                      spacing: 15,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // 🏠 Home: Welcome Text
          if (_selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      " Welcome To My Team Hockey!!! ",
                      style: GoogleFonts.agbalumo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.3),
                            offset: Offset(3, 3),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // 🔍 Search Tab
          if (_selectedIndex == 1) SearchTeamPage(),

          // 🏒 Players List Tab
          if (_selectedIndex == 3) _buildPlayersList(),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: showBottom,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: Icon(Icons.play_circle_sharp, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(
        elevation: 100.0,
        backgroundColor: Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.white],
                ),
              ),
              accountName: Text(
                "Bala Ganesh V.",
                style: GoogleFonts.agbalumo(),
              ),
              accountEmail: Text(
                "balahockey@123gmail.com",
                style: GoogleFonts.oldStandardTt(),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.cyanAccent,
                backgroundImage: AssetImage("assets/images/download.jpeg"),
              ),
              currentAccountPictureSize: Size(70, 70),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    "assets/images/download (1) - Copy.jpeg",
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.emoji_events_outlined, color: Colors.black),
              title: Text("Upcoming Events"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpcomingEventsPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.history, color: Colors.black),
              title: Text("History"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchHistoryPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.live_tv, color: Colors.black),
              title: Text("Highlights"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HighlightsPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.date_range, color: Colors.black),
              title: Text("Match fixtures"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchFixturesPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.play_circle_sharp, color: Colors.black),
              title: Text("Live"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: showBottom,
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.rule_sharp, color: Colors.black),
              title: Text("Match Rules"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchRulesPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.phone_in_talk_rounded, color: Colors.black),
              title: Text("Contact"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.people_rounded, color: Colors.black),
              title: Text("Join Club"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinClubPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text("Settings"),
              titleTextStyle: GoogleFonts.oldenburg(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            Divider(height: 10, color: Colors.black, thickness: 0.5),
            AboutListTile(
              icon: Icon(Icons.info),
              applicationIcon: Icon(Icons.info_outline, size: 24),
              applicationName: "My Team Hockey",
              applicationVersion: "Version 10.2",
              applicationLegalese: "© 2025 PPG Hockey Team",
              aboutBoxChildren: [
                Text(
                  "This app is for managing and viewing hockey team details.",
                ),
                Divider(height: 10, color: Colors.black, thickness: 0.5),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemPressed,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 16),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_filled, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: "Add team",
            icon: Icon(Icons.add, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: "Players List",
            icon: Icon(Icons.list_alt, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
