import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../matches/create_match_page.dart';
import '../matches/live_match_page.dart';
import '../tournaments/widgets/upcoming_tournaments_section.dart';
import 'widgets/todays_live_matches_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D18),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar (Logo & Icons)
              _buildTopBar(context),
              const SizedBox(height: 24),

              // Greeting & Headline
              Text(
                'Welcome back!',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  children: const [
                    TextSpan(text: 'Game '),
                    TextSpan(
                      text: 'Smarter.',
                      style: TextStyle(color: Color(0xFF39FF14)),
                    ),
                    TextSpan(text: ' Win Better.'),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'AI-powered insights for every hockey moment.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              // Hero Live Match Card
              _buildLiveMatchHero(context),
              const SizedBox(height: 20),

              // Quick Action Cards (3 items in a row)
              Row(
                children: [
                  _buildQuickAction(
                    context,
                    icon: Icons.calendar_today_outlined,
                    title: 'Create Match',
                    subtitle: 'Schedule a new match',
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
                  _buildQuickAction(
                    context,
                    icon: Icons.sensors_rounded,
                    title: 'Go Live',
                    subtitle: 'Stream your match',
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
                  _buildQuickAction(
                    context,
                    icon: Icons.bar_chart_rounded,
                    title: 'AI Analytics',
                    subtitle: 'Advanced insights',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Auto-Scrolling Today's Live Matches Section
              const TodaysLiveMatchesSection(),

              const SizedBox(height: 24),

              // Upcoming Tournaments Section
              const UpcomingTournamentsSection(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF39FF14),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sports_hockey,
                color: Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI HOCKEY',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'INTELLIGENCE',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF39FF14),
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF39FF14),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF39FF14), width: 1.5),
              ),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF191D20),
                child: Icon(Icons.person, color: Colors.white70, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveMatchHero(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101B2B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF39FF14).withValues(alpha: 0.2),
        ),
        gradient: const RadialGradient(
          center: Alignment(0, -0.4),
          radius: 1.2,
          colors: [Color(0xFF0F2E23), Color(0xFF0D1724)],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: LIVE badge, Tournament name, timer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'LIVE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Local Tournament',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 14,
                    color: Color(0xFF39FF14),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '75:23',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4325),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '2nd Half',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF39FF14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 12,
                color: Color(0xFF94A3B8),
              ),
              const SizedBox(width: 4),
              Text(
                'PPG Hockey Ground',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Score Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Home Team
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF162337),
                      border: Border.all(
                        color: const Color(0xFF39FF14),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'P',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'PPG',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Home',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),

              // Score
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                      ),
                      children: const [
                        TextSpan(
                          text: '3 ',
                          style: TextStyle(color: Color(0xFF39FF14)),
                        ),
                        TextSpan(
                          text: '- 2',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'VS',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),

              // Away Team
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF162337),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        'T',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'TIGERS',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Away',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF101B2B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF39FF14).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF39FF14), size: 22),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: const Color(0xFF94A3B8),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
