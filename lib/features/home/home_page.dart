import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';
import '../matches/create_match_page.dart';
import '../matches/live_match_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PremiumHeader(
                title: 'AI Hockey Intelligence',
                subtitle: 'Smart insights. Better hockey.',
              ),
              const SizedBox(height: 8),

              LiveMatchCard(
                match: const {
                  'homeTeam': 'PPG',
                  'homeScore': '3',
                  'awayTeam': 'TIGERS',
                  'awayScore': '2',
                  'period': 'Q3',
                  'time': '42:18',
                  'competition': 'Local Tournament',
                  'location': 'PPG Hockey Ground',
                },
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

              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    QuickActionCard(
                      icon: Icons.add_rounded,
                      title: 'CREATE MATCH',
                      subtitle: 'Start a new match',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateMatchPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    QuickActionCard(
                      icon: Icons.sensors_rounded,
                      title: 'GO LIVE',
                      subtitle: 'Start live coverage',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LiveMatchPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    QuickActionCard(
                      icon: Icons.analytics_outlined,
                      title: 'AI ANALYTICS',
                      subtitle: 'View insights',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // AI Match Insights and Live Statistics sections removed
              const SizedBox(height: 32),
              _buildSectionHeader('UPCOMING MATCHES'),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: const [
                    UpcomingMatchCard(
                      match: {
                        'date': 'SAT, AUG 15',
                        'time': '4:30 PM',
                        'homeTeam': 'PPG',
                        'awayTeam': 'LIONS',
                        'location': 'PPG Hockey Ground',
                      },
                    ),
                    UpcomingMatchCard(
                      match: {
                        'date': 'SUN, AUG 16',
                        'time': '10:00 AM',
                        'homeTeam': 'HAWKS',
                        'awayTeam': 'PPG',
                        'location': 'City Stadium',
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: const Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: Color(0xFF39FF14),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF39FF14),
                    size: 10,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
