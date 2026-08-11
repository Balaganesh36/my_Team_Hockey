import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModernAppBar(
        title: 'Platform',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF1A1A1A),
            child: Icon(Icons.person, size: 20, color: Colors.white54),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Live Match',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const MatchCard(
              match: {
                'homeTeam': 'PPG',
                'awayTeam': 'TIGERS',
                'score': '3 - 2',
                'competition': 'Local Tournament',
                'location': 'PPG Hockey Ground',
              },
              isHero: true,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildQuickAction(
                  context,
                  Icons.add_circle_outline_rounded,
                  'Create Match',
                ),
                const SizedBox(width: 12),
                _buildQuickAction(context, Icons.stream_rounded, 'Go Live'),
                const SizedBox(width: 12),
                _buildQuickAction(
                  context,
                  Icons.analytics_outlined,
                  'AI Analytics',
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Intelligence',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(color: Color(0xFF39FF14), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const AIInsightCard(
              title: 'Performance Spike',
              content:
                  'Team speed increased by 12% in the second half of the last match.',
              icon: Icons.trending_up_rounded,
            ),
            const AIInsightCard(
              title: 'Tactical Shift',
              content:
                  'Opposition changed to a 3-4-3 formation. Defensive response was optimal.',
              icon: Icons.psychology_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF39FF14)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
