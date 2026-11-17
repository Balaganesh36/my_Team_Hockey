import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/widgets/app_widgets.dart';

class AddMatchFixturePage extends StatefulWidget {
  final Map<String, dynamic> tournament;

  const AddMatchFixturePage({super.key, required this.tournament});

  @override
  State<AddMatchFixturePage> createState() => _AddMatchFixturePageState();
}

class _AddMatchFixturePageState extends State<AddMatchFixturePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _teamAController;
  late TextEditingController _teamBController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _venueController;

  String _stage = 'Group Stage - Round 1';
  final List<String> _stages = [
    'Group Stage - Round 1',
    'Group Stage - Round 2',
    'Quarter Final',
    'Semi Final',
    'Final',
    'Friendly',
  ];

  late String _generatedMatchId;

  @override
  void initState() {
    super.initState();
    final random = Random();
    final randomNum = 1000 + random.nextInt(9000);
    _generatedMatchId = 'HK2026-$randomNum';

    final teams = (widget.tournament['teams'] as List?)?.cast<String>() ?? [];
    _teamAController = TextEditingController(
      text: teams.isNotEmpty ? teams[0] : 'PPG',
    );
    _teamBController = TextEditingController(
      text: teams.length > 1 ? teams[1] : 'TIGERS',
    );
    _dateController = TextEditingController(
      text: DateTime.now().toIso8601String().substring(0, 10),
    );
    _timeController = TextEditingController(text: '10:00 AM');
    _venueController = TextEditingController(
      text: widget.tournament['venue'] ?? '',
    );
  }

  @override
  void dispose() {
    _teamAController.dispose();
    _teamBController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _venueController.dispose();
    super.dispose();
  }

  void _saveFixture() {
    if (_teamAController.text.trim().isEmpty ||
        _teamBController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please specify Team A and Team B')),
      );
      return;
    }

    final newFixture = {
      'id': _generatedMatchId,
      'teamA': _teamAController.text.trim().toUpperCase(),
      'teamB': _teamBController.text.trim().toUpperCase(),
      'matchDate':
          '${_dateController.text.trim()} ${_timeController.text.trim()}',
      'venue': _venueController.text.trim().isEmpty
          ? 'Hockey Field'
          : _venueController.text.trim(),
      'stage': _stage,
    };

    final fixtures =
        (widget.tournament['fixtures'] as List?)
            ?.cast<Map<String, dynamic>>() ??
        [];
    fixtures.add(newFixture);
    widget.tournament['fixtures'] = fixtures;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Fixture $_generatedMatchId saved successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D18),
      appBar: const ModernAppBar(title: 'Add Match Fixture'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Generated Match ID Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF101B2B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF39FF14).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MATCH ID',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF94A3B8),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _generatedMatchId,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF39FF14),
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _generatedMatchId),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Match ID copied to clipboard'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 14,
                        color: Color(0xFF39FF14),
                      ),
                      label: Text(
                        'COPY',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF39FF14),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF39FF14)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Team Selections
              Text(
                'PARTICIPATING TEAMS',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF39FF14),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _teamAController,
                      label: 'Team A',
                      hint: 'e.g. PPG',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'VS',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildInputField(
                      controller: _teamBController,
                      label: 'Team B',
                      hint: 'e.g. TIGERS',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Match Details
              Text(
                'FIXTURE DETAILS',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF39FF14),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              _buildDropdownField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _dateController,
                      label: 'Date',
                      hint: 'YYYY-MM-DD',
                      icon: Icons.calendar_month_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      controller: _timeController,
                      label: 'Time',
                      hint: '10:00 AM',
                      icon: Icons.access_time_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _venueController,
                label: 'Venue',
                hint: 'Venue / Pitch name',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 32),

              // Save Fixture Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveFixture,
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                  label: Text(
                    'SAVE FIXTURE',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF39FF14),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 13),
            prefixIcon: icon != null
                ? Icon(icon, color: const Color(0xFF39FF14), size: 18)
                : null,
            filled: true,
            fillColor: const Color(0xFF101B2B),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF39FF14)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Round / Stage',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF101B2B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _stage,
              dropdownColor: const Color(0xFF101B2B),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF39FF14),
              ),
              isExpanded: true,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              items: _stages.map((stg) {
                return DropdownMenuItem<String>(value: stg, child: Text(stg));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _stage = val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
