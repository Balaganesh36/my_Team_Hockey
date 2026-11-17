import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/widgets/app_widgets.dart';
import '../data/tournament_mock_data.dart';
import 'register_tournament_page.dart';

class ManageTournamentPage extends StatefulWidget {
  final Map<String, dynamic> tournament;

  const ManageTournamentPage({super.key, required this.tournament});

  @override
  State<ManageTournamentPage> createState() => _ManageTournamentPageState();
}

class _ManageTournamentPageState extends State<ManageTournamentPage> {
  @override
  Widget build(BuildContext context) {
    final t = widget.tournament;
    final status = t['status'] ?? 'Draft';
    final fixtures =
        (t['fixtures'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF080D18),
      appBar: const ModernAppBar(title: 'Manage Tournament'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF101B2B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STATUS MANAGEMENT',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF39FF14),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Draft',
                      'Pending',
                      'Approved',
                      'Rejected',
                    ].map((st) => _buildStatusChip(st, status == st)).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterTournamentPage(
                            initialData: t,
                            isEditing: true,
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    icon: const Icon(Icons.edit, size: 16, color: Colors.black),
                    label: Text(
                      'EDIT DETAILS',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF39FF14),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showDeleteDialog();
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: Color(0xFFEF4444),
                    ),
                    label: Text(
                      'DELETE',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Fixtures Management
            Text(
              'MANAGE FIXTURES (${fixtures.length})',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF39FF14),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            fixtures.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101B2B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'No fixtures to manage.',
                        style: GoogleFonts.inter(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: fixtures.length,
                    itemBuilder: (context, index) {
                      final f = fixtures[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101B2B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${f['teamA']} VS ${f['teamB']}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${f['stage']} • ${f['matchDate']}',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Color(0xFFEF4444),
                              ),
                              onPressed: () {
                                setState(() {
                                  fixtures.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Fixture removed'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isSelected) {
    final color = TournamentMockData.getStatusColor(label);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            widget.tournament['status'] = label;
          });
        }
      },
      selectedColor: color.withValues(alpha: 0.2),
      backgroundColor: const Color(0xFF162337),
      labelStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? color : Colors.white54,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide(color: isSelected ? color : Colors.transparent),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101B2B),
        title: Text(
          'Delete Tournament',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete this tournament? This action cannot be undone.',
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            onPressed: () {
              TournamentMockData.tournaments.removeWhere(
                (t) => t['id'] == widget.tournament['id'],
              );
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // close manage page
              Navigator.pop(context); // close details page
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
