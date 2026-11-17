import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/widgets/app_widgets.dart';
import '../data/tournament_mock_data.dart';
import 'add_match_fixture_page.dart';
import 'manage_tournament_page.dart';

class TournamentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> tournament;

  const TournamentDetailsPage({super.key, required this.tournament});

  @override
  State<TournamentDetailsPage> createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tournament;
    final status = t['status'] ?? 'Draft';
    final statusColor = TournamentMockData.getStatusColor(status);
    final fixtures =
        (t['fixtures'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final teams = (t['teams'] as List?)?.cast<String>() ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF080D18),
      appBar: ModernAppBar(
        title: t['name'] ?? 'Tournament Details',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            tooltip: 'Manage Tournament',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageTournamentPage(tournament: t),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Card
          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF101B2B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
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
                      t['category'] ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF39FF14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  t['name'] ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 18,
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
                      '${t['startDate']} to ${t['endDate']}',
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
                    Text(
                      '${t['venue']}, ${t['city']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF39FF14),
            labelColor: const Color(0xFF39FF14),
            unselectedLabelColor: const Color(0xFF94A3B8),
            labelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            tabs: const [
              Tab(text: 'MATCHES'),
              Tab(text: 'TEAMS'),
              Tab(text: 'DETAILS'),
            ],
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMatchesTab(fixtures),
                _buildTeamsTab(teams),
                _buildDetailsTab(t),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesTab(List<Map<String, dynamic>> fixtures) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Match Fixtures (${fixtures.length})',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddMatchFixturePage(tournament: widget.tournament),
                    ),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.add, size: 16, color: Colors.black),
                label: Text(
                  'Add Fixture',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39FF14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: fixtures.isEmpty
              ? _buildEmptyTab('No match fixtures created yet.')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: fixtures.length,
                  itemBuilder: (context, index) {
                    final f = fixtures[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101B2B),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                f['stage'] ?? 'Fixture',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFF39FF14),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ID: ${f['id']}',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: const Color(0xFF94A3B8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 12,
                                      color: Color(0xFF94A3B8),
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: f['id']),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Match ID copied!'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.only(left: 4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                f['teamA'] ?? 'Team A',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  'VS',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ),
                              Text(
                                f['teamB'] ?? 'Team B',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                f['matchDate'] ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                              Text(
                                f['venue'] ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTeamsTab(List<String> teams) {
    final controller = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Participating Teams (${teams.length})',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color(0xFF101B2B),
                      title: Text(
                        'Add Team',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                      content: TextField(
                        controller: controller,
                        style: GoogleFonts.inter(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Team Name (e.g. PPG ALUMNI)',
                          hintStyle: GoogleFonts.inter(color: Colors.white38),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CANCEL'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.text.trim().isNotEmpty) {
                              setState(() {
                                teams.add(controller.text.trim().toUpperCase());
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: const Text('ADD'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 16, color: Colors.black),
                label: Text(
                  'Add Team',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39FF14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: teams.isEmpty
              ? _buildEmptyTab('No teams added yet.')
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final teamName = teams[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101B2B),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFF162337),
                            child: Text(
                              teamName.substring(0, 1),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF39FF14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              teamName,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDetailsTab(Map<String, dynamic> t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailGroup('DESCRIPTION', t['description'] ?? 'N/A'),
          const SizedBox(height: 16),
          _buildDetailGroup('CATEGORY', t['category'] ?? 'N/A'),
          const SizedBox(height: 16),
          _buildDetailGroup('DATES', '${t['startDate']} to ${t['endDate']}'),
          const SizedBox(height: 16),
          _buildDetailGroup('VENUE & CITY', '${t['venue']}, ${t['city']}'),
          const SizedBox(height: 16),
          _buildDetailGroup('ORGANISER NAME', t['organiserName'] ?? 'N/A'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildDetailGroup('PHONE', t['phone'] ?? 'N/A')),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailGroup('WHATSAPP', t['whatsapp'] ?? 'N/A'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailGroup('EMAIL', t['email'] ?? 'N/A'),
          const SizedBox(height: 16),
          _buildDetailGroup(
            'REGISTRATION LINK',
            t['registrationLink'] ?? 'N/A',
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ManageTournamentPage(tournament: widget.tournament),
                  ),
                );
                setState(() {});
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: Color(0xFF39FF14),
              ),
              label: Text(
                'MANAGE / EDIT TOURNAMENT',
                style: GoogleFonts.inter(
                  color: const Color(0xFF39FF14),
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFF39FF14)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailGroup(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF94A3B8),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTab(String message) {
    return Center(
      child: Text(
        message,
        style: GoogleFonts.inter(color: Colors.white54, fontSize: 13),
      ),
    );
  }
}
