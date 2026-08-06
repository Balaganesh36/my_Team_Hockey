import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/app_widgets.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: const Color(0xFF1565C0),
            labelColor: const Color(0xFF1565C0),
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: "FIXTURES"),
              Tab(text: "HISTORY"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [_buildFixturesList(), _buildHistoryList()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixturesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: AppConstants.fixtures.length,
      itemBuilder: (context, index) {
        final fixture = AppConstants.fixtures[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SportsCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fixture['homeTeam'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    fixture['time'],
                    style: const TextStyle(
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    fixture['awayTeam'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: AppConstants.matchHistory.length,
      itemBuilder: (context, index) {
        final match = AppConstants.matchHistory[index];
        final bool isWin = match['result'].toLowerCase() == 'win';
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SportsCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      match['competition'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      match['date'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        match['opponent'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      match['score'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isWin ? Colors.green : Colors.red).withValues(
                      alpha: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    match['result'].toUpperCase(),
                    style: TextStyle(
                      color: isWin ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
