// add_team_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTeamPage extends StatefulWidget {
  const AddTeamPage({super.key});

  @override
  State<AddTeamPage> createState() => _AddTeamPageState();
}

class _AddTeamPageState extends State<AddTeamPage> {
  static const int minPlayers = 11;
  static const int maxPlayers = 18;

  final TextEditingController _teamNameController = TextEditingController();
  final List<String> _players = [];

  void _addPlayer(BuildContext context) async {
    if (_players.length >= maxPlayers) return;

    final playerController = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog.adaptive(
          title: Text(
            "Add Player",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: TextField(
              controller: playerController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Full name",
                labelStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
              ),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text("Cancel", style: GoogleFonts.poppins()),
            ),
            FilledButton(
              onPressed: () {
                final value = playerController.text.trim();
                if (value.isEmpty) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text("Player name cannot be empty!"),
                      backgroundColor: Colors.red.shade700,
                    ),
                  );
                  return;
                }
                Navigator.of(ctx).pop(value);
              },
              child: Text(
                "Add",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _players.add(result);
      });

      if (_players.length == maxPlayers) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Maximum of $maxPlayers players reached."),
            backgroundColor: Colors.deepPurple.shade700,
          ),
        );
      }
    }
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  void _saveTeam() {
    final teamName = _teamNameController.text.trim();

    if (teamName.isEmpty) {
      _showError("Please enter a team name!");
      return;
    }

    if (_players.length < minPlayers) {
      _showError("You need at least $minPlayers players to save.");
      return;
    }

    // Success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$teamName" saved successfully!'),
        backgroundColor: Colors.green.shade700,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context, {
        'teamName': teamName,
        'players': List.of(_players),
      });
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.orange.shade700),
    );
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMinMet = _players.length >= minPlayers;
    final isMaxReached = _players.length >= maxPlayers;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Create New Team",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
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
              Colors.black.withOpacity(0.65),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔤 Team Name
              Text(
                "Team Name",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _teamNameController,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "e.g., PPG Warriors",
                    hintStyle: GoogleFonts.poppins(color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // 👥 Players Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team Roster",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${_players.length} / $maxPlayers players",
                        style: GoogleFonts.poppins(
                          color: isMaxReached
                              ? Colors.redAccent
                              : Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  FilledButton.icon(
                    onPressed: isMaxReached ? null : () => _addPlayer(context),
                    icon: Icon(Icons.person_add, size: 18),
                    label: Text(
                      "Add Player",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: isMaxReached
                          ? Colors.grey[700]
                          : Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 📋 Player List
              Expanded(
                child: _players.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group,
                                size: 60,
                                color: Colors.white38,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No players added yet",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white60,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Add at least $minPlayers players to save your team.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _players.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, index) {
                          return Dismissible(
                            key: Key(_players[index]),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red.shade700,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) => _removePlayer(index),
                            child: Card(
                              margin: EdgeInsets.only(bottom: 10),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Colors.white.withOpacity(0.08),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  _players[index],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.drag_handle,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // ✅ Save Button
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isMinMet ? _saveTeam : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: isMinMet
                          ? Colors.black
                          : Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: isMinMet ? 3 : 0,
                    ),
                    child: Text(
                      isMinMet
                          ? "Save Team"
                          : "Add ${minPlayers - _players.length} More Players",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
