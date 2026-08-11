import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

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
                onWatchLive: () {},
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
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    QuickActionCard(
                      icon: Icons.sensors_rounded,
                      title: 'GO LIVE',
                      subtitle: 'Start live coverage',
                      onTap: () {},
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
              _buildSectionHeader('AI MATCH INSIGHTS', onViewAll: () {}),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    AIInsightCard(
                      category: 'AI Insight',
                      time: '2 min ago',
                      title: 'Performance Spike',
                      content:
                          '+12% team speed in the second half compared to season average.',
                      icon: Icons.trending_up_rounded,
                    ),
                    AIInsightCard(
                      category: 'Tactical',
                      time: '15 min ago',
                      title: 'Tactical Shift',
                      content:
                          'Opposition changed to a 3-4-3 formation. Defensive response required.',
                      icon: Icons.psychology_rounded,
                    ),
                    AIInsightCard(
                      category: 'Defense',
                      time: '20 min ago',
                      title: 'Defensive Alert',
                      content:
                          'Right-side defensive pressure increased during Q3.',
                      icon: Icons.security_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              _buildSectionHeader('LIVE STATISTICS'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    StatCard(
                      label: 'Possession',
                      value: '54%',
                      icon: Icons.pie_chart_outline_rounded,
                    ),
                    StatCard(
                      label: 'Shots',
                      value: '18',
                      icon: Icons.sports_hockey_rounded,
                    ),
                    StatCard(
                      label: 'On Target',
                      value: '11',
                      icon: Icons.track_changes_rounded,
                    ),
                    StatCard(
                      label: 'P. Corners',
                      value: '6',
                      icon: Icons.flag_outlined,
                    ),
                  ],
                ),
              ),

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
