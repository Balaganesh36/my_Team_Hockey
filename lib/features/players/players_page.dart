import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/app_widgets.dart';
import 'add_team_page.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredPlayers = AppConstants.players
        .where(
          (p) => p['name'].toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: "Search players...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredPlayers.length,
              itemBuilder: (context, index) {
                return PlayerCard(
                  player: filteredPlayers[index],
                  onTap: () =>
                      _showPlayerDetails(context, filteredPlayers[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTeamPage()),
          );
        },
        label: const Text("Add Team"),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xFF1565C0),
      ),
    );
  }

  void _showPlayerDetails(BuildContext context, Map<String, dynamic> player) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(32),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: player['image'] != null
                        ? AssetImage(player['image'])
                        : null,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player['name'],
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          player['position'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1565C0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "JERSEY #${player['jerseyNumber']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                "BIOGRAPHY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                player['bio'],
                style: TextStyle(color: Colors.grey[600], height: 1.6),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("AGE", player['age'].toString()),
                  _buildStatItem("MATCHES", "42"),
                  _buildStatItem("GOALS", "15"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
