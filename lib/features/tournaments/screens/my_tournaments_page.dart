import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/widgets/app_widgets.dart';
import '../data/tournament_mock_data.dart';
import 'register_tournament_page.dart';
import 'tournament_details_page.dart';

class MyTournamentsPage extends StatefulWidget {
  const MyTournamentsPage({super.key});

  @override
  State<MyTournamentsPage> createState() => _MyTournamentsPageState();
}

class _MyTournamentsPageState extends State<MyTournamentsPage> {
  @override
  Widget build(BuildContext context) {
    final tournaments = TournamentMockData.tournaments;

    return Scaffold(
      backgroundColor: const Color(0xFF080D18),
      appBar: const ModernAppBar(title: 'My Tournaments'),
      body: tournaments.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                final item = tournaments[index];
                final status = item['status'] ?? 'Draft';
                final statusColor = TournamentMockData.getStatusColor(status);
                final fixturesCount = (item['fixtures'] as List?)?.length ?? 0;

                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TournamentDetailsPage(tournament: item),
                      ),
                    );
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101B2B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: statusColor.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Text(
                                status.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: statusColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Text(
                              item['category'] ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['name'] ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 13,
                              color: Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${item['startDate']} - ${item['endDate']}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 13,
                              color: Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${item['venue']}, ${item['city']}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: const Color(0xFF94A3B8),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.white10, height: 1),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$fixturesCount Match Fixtures',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF39FF14),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'VIEW DETAILS',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterTournamentPage(),
            ),
          );
          setState(() {});
        },
        backgroundColor: const Color(0xFF39FF14),
        icon: const Icon(Icons.add, color: Colors.black),
        label: Text(
          'Register Tournament',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events_outlined,
            size: 64,
            color: Colors.white24,
          ),
          const SizedBox(height: 16),
          Text(
            'No registered tournaments yet',
            style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
