import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/tournament_mock_data.dart';
import '../screens/my_tournaments_page.dart';
import '../screens/tournament_details_page.dart';

class UpcomingTournamentsSection extends StatelessWidget {
  const UpcomingTournamentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter upcoming / approved / active tournaments
    final tournaments = TournamentMockData.tournaments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF39FF14),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'UPCOMING TOURNAMENTS',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyTournamentsPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'VIEW ALL',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF39FF14),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF39FF14),
                      size: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Horizontal Carousel
        if (tournaments.isEmpty)
          _buildEmptyState()
        else
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                final tournament = tournaments[index];
                return _buildTournamentCard(context, tournament);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.emoji_events_outlined,
              color: Colors.white38,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              'No upcoming tournaments available',
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentCard(
    BuildContext context,
    Map<String, dynamic> tournament,
  ) {
    final status = tournament['status'] ?? 'Approved';
    final statusColor = TournamentMockData.getStatusColor(status);
    final teamsCount = (tournament['teams'] as List?)?.length ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TournamentDetailsPage(tournament: tournament),
          ),
        );
      },
      child: Container(
        width: 290,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF101B2B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Category Badge + Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF39FF14).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF39FF14).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    tournament['category'] ?? 'Tournament',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF39FF14),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Tournament Name
            Text(
              tournament['name'] ?? '',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            // Dates
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 12,
                  color: Color(0xFF94A3B8),
                ),
                const SizedBox(width: 4),
                Text(
                  '${tournament['startDate']} - ${tournament['endDate']}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Venue
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 12,
                  color: Color(0xFF94A3B8),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${tournament['venue']}, ${tournament['city']}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(color: Colors.white10, height: 1),
            const SizedBox(height: 8),

            // Card Bottom: Organiser & Teams Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'By ${tournament['organiserName'] ?? 'Organiser'}',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '$teamsCount Teams Registered',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF39FF14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
