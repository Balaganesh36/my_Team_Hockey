import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/app_widgets.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModernAppBar(title: 'Player Database'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Players...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF39FF14),
                ),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('Forwards', false),
                _buildFilterChip('Defenders', false),
                _buildFilterChip('Midfielders', false),
                _buildFilterChip('Goalkeepers', false),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: AppConstants.players.length,
              itemBuilder: (context, index) {
                return PlayerCard(player: AppConstants.players[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {},
        backgroundColor: const Color(0xFF1A1A1A),
        selectedColor: const Color(0xFF39FF14).withValues(alpha: 0.2),
        checkmarkColor: const Color(0xFF39FF14),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF39FF14) : Colors.white54,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(
          color: isSelected ? const Color(0xFF39FF14) : Colors.transparent,
        ),
      ),
    );
  }
}
