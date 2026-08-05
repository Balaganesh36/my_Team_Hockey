// search_team_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model class for Team
class Team {
  final String name;
  final List<String> players;

  Team({required this.name, required this.players});
}

class SearchTeamPage extends StatefulWidget {
  const SearchTeamPage({super.key});

  @override
  State<SearchTeamPage> createState() => _SearchTeamPageState();
}

class _SearchTeamPageState extends State<SearchTeamPage> {
  final List<Team> _allTeams = [
    Team(name: 'PPG Warriors', players: ['Alice', 'Bob', 'Charlie', 'David']),
    Team(name: 'Thunderbolts', players: ['Eve', 'Frank', 'Grace']),
    Team(name: 'Sky Hawks', players: ['Heidi', 'Ivan', 'Judy', 'Kevin', 'Leo']),
    Team(name: 'Blue Lions', players: ['Mallory', 'Niaj', 'Olivia', 'Peggy']),
    Team(name: 'Red Foxes', players: ['Sybil', 'Trent', 'Wendy']),
    Team(name: 'Mountain Kings', players: ['Alice', 'Zoe', 'John']),
  ];

  List<Team> _filteredTeams = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredTeams = _allTeams;
    _searchController.addListener(_filterTeams);
  }

  void _filterTeams() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() => _filteredTeams = _allTeams);
    } else {
      setState(() {
        _filteredTeams = _allTeams
            .where(
              (team) =>
                  team.name.toLowerCase().contains(query) ||
                  team.players.any(
                    (player) => player.toLowerCase().contains(query),
                  ),
            )
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark background for contrast
      appBar: AppBar(
        title: Text(
          "Search Teams",
          style: GoogleFonts.oldenburg(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/images.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search Field – Elevated & Modern
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Search teams or players...",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 📊 Results Count
              Text(
                "${_filteredTeams.length} ${_filteredTeams.length == 1 ? 'Team' : 'Teams'} Found",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // 📋 Team List
              Expanded(
                child: _filteredTeams.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 60,
                              color: Colors.white38,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No teams found",
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Try a different name or player",
                              style: GoogleFonts.poppins(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: _filteredTeams.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (ctx, index) {
                          final team = _filteredTeams[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            color: Colors.white.withOpacity(0.08),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              title: Text(
                                team.name,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "${team.players.length} players",
                                style: GoogleFonts.poppins(
                                  color: Colors.white60,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.deepPurpleAccent,
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Viewing: ${team.name}"),
                                    backgroundColor: Colors.deepPurple.shade800,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
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
