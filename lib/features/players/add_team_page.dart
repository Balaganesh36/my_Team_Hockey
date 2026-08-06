import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

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
        return AlertDialog(
          title: const Text("Add Player"),
          content: TextField(
            controller: playerController,
            autofocus: true,
            decoration: const InputDecoration(labelText: "Player Name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(playerController.text),
              child: const Text("Add"),
            ),
          ],
        );
      },
    );

    if (result != null && result.trim().isNotEmpty) {
      setState(() => _players.add(result.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Team")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SportsCard(
              child: TextField(
                controller: _teamNameController,
                decoration: const InputDecoration(
                  labelText: "Team Name",
                  hintText: "Enter team name",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Roster (${_players.length}/$maxPlayers)",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _players.length < maxPlayers
                      ? () => _addPlayer(context)
                      : null,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Player"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _players.isEmpty
                  ? const Center(child: Text("No players added yet"))
                  : ListView.builder(
                      itemCount: _players.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(_players[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                setState(() => _players.removeAt(index)),
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            GradientButton(
              text: "SAVE TEAM",
              onPressed: _players.length >= minPlayers
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Team Saved!")),
                      );
                      Navigator.pop(context);
                    }
                  : () {},
            ),
          ],
        ),
      ),
    );
  }
}
