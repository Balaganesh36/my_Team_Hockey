// match_fixtures_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchFixturesPage extends StatelessWidget {
  const MatchFixturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample fixture data
    List<Map<String, dynamic>> fixtures = [
      {'time': '6:30 AM', 'homeTeam': 'PPG', 'awayTeam': 'KCT'},
      {'time': '8:15 AM', 'homeTeam': 'UIT', 'awayTeam': 'SNS'},
      {'time': '10:00 AM', 'homeTeam': 'PPG ALUMNI', 'awayTeam': 'ADHIYAMAN '},
      {'time': '11:45 AM', 'homeTeam': 'PSG ', 'awayTeam': 'HIET '},
      {'time': '3:00 PM', 'homeTeam': 'SUGNA CASE', 'awayTeam': 'KONGU'},
      {'time': '5:00 PM', 'homeTeam': 'PAVAI', 'awayTeam': 'PPG'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Match Fixtures",
          style: GoogleFonts.oldenburg(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              // --- Replace with your actual image path ---
              "assets/images/images.jpeg",
              // Example: "assets/images/ice_rink_background.jpg",
              // --- Replace with your actual image path ---
            ),
            fit: BoxFit.cover, // Cover the entire container
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[800]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Column(
                  children: [
                    Text(
                      "ZONE11 ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "PPG HOCKEY TURF ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "MATCH SCHEDULE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "(THURSDAY 26 SEPTEMBER 2025)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Match Schedule
              Expanded(
                child: ListView.builder(
                  itemCount: fixtures.length,
                  itemBuilder: (context, index) {
                    final fixture = fixtures[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Home Team
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                fixture['homeTeam'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // VS Separator
                          Text(
                            "VS",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 16),
                          // Away Team
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                fixture['awayTeam'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
