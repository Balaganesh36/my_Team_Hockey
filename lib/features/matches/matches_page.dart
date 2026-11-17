import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';
import '../tournaments/screens/my_tournaments_page.dart';
import 'live_match_page.dart';
import 'create_match_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModernAppBar(
        title: 'Match Center',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.emoji_events_outlined,
              color: Color(0xFF39FF14),
            ),
            tooltip: 'My Tournaments',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyTournamentsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF39FF14),
            labelColor: const Color(0xFF39FF14),
            unselectedLabelColor: Colors.white54,
            tabs: const [
              Tab(text: 'LIVE'),
              Tab(text: 'UPCOMING'),
              Tab(text: 'HISTORY'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMatchList(true),
                _buildMatchList(false),
                _buildMatchList(false),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateMatchPage()),
          );
        },
        backgroundColor: const Color(0xFF39FF14),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildMatchList(bool isLive) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) {
        final matchData = {
          'homeTeam': index % 2 == 0 ? 'PPG' : 'TIGERS',
          'homeScore': isLive ? (index + 1).toString() : '0',
          'awayTeam': index % 2 == 0 ? 'LIONS' : 'HAWKS',
          'awayScore': isLive ? index.toString() : '0',
          'score': isLive ? '1 - 1' : '0 - 0',
          'competition': 'Local Tournament',
          'location': 'PPG Hockey Ground',
          'period': 'Q${(index % 4) + 1}',
          'time': '${(index * 2) + 10}:15',
        };

        if (isLive) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: LiveMatchCard(
              match: matchData,
              onWatchLive: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LiveMatchPage(),
                  ),
                );
              },
              onDetails: () {},
            ),
          );
        }

        return MatchCard(match: matchData);
      },
    );
  }
}
