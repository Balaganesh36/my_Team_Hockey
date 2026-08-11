import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/app_widgets.dart';

class CreateMatchPage extends StatefulWidget {
  const CreateMatchPage({super.key});

  @override
  State<CreateMatchPage> createState() => _CreateMatchPageState();
}

class _CreateMatchPageState extends State<CreateMatchPage> {
  int _currentStep = 0;

  // Controllers
  final _titleController = TextEditingController();
  final _tournamentController = TextEditingController();
  final _venueController = TextEditingController();

  // Configuration
  final String _selectedHomeTeam = 'PPG';
  final String _selectedAwayTeam = 'TIGERS';
  String _selectedFormat = '4 × 15 MIN';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D0F),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _buildCurrentStep(),
              ),
            ),
            _buildBottomAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'CREATE MATCH',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Set up your hockey match before going live.',
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _buildStep(0, 'Details'),
          _buildLine(0),
          _buildStep(1, 'Teams'),
          _buildLine(1),
          _buildStep(2, 'Review'),
        ],
      ),
    );
  }

  Widget _buildStep(int index, String label) {
    bool isActive = _currentStep >= index;
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF39FF14) : Colors.white10,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white24,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white24,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int index) {
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: _currentStep > index ? const Color(0xFF39FF14) : Colors.white10,
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildMatchDetails();
      case 1:
        return _buildTeamsAndFormat();
      case 2:
        return _buildReview();
      default:
        return const SizedBox();
    }
  }

  Widget _buildMatchDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'MATCH DETAILS'),
        const Text(
          'Enter the basic information for your match.',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
        const SizedBox(height: 20),
        _buildInputField(
          controller: _titleController,
          label: 'MATCH TITLE',
          hint: 'e.g., PPG vs Tigers',
          icon: Icons.title_rounded,
        ),
        const SizedBox(height: 16),
        _buildInputField(
          controller: _tournamentController,
          label: 'TOURNAMENT',
          hint: 'e.g., Local Hockey Tournament',
          icon: Icons.emoji_events_rounded,
        ),
        const SizedBox(height: 16),
        _buildInputField(
          controller: _venueController,
          label: 'VENUE',
          hint: 'e.g., PPG Hockey Ground',
          icon: Icons.location_on_rounded,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildPickerField(
                label: 'DATE',
                value:
                    '${_selectedDate.day} ${_getMonth(_selectedDate.month)} ${_selectedDate.year}',
                icon: Icons.calendar_today_rounded,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) setState(() => _selectedDate = date);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildPickerField(
                label: 'START TIME',
                value: _selectedTime.format(context),
                icon: Icons.access_time_rounded,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (time != null) setState(() => _selectedTime = time);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamsAndFormat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'TEAMS'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTeamSelector('HOME TEAM', _selectedHomeTeam, true),
            Text(
              'VS',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                color: Colors.white10,
                fontSize: 24,
              ),
            ),
            _buildTeamSelector('AWAY TEAM', _selectedAwayTeam, false),
          ],
        ),
        const SizedBox(height: 40),
        const SectionHeader(title: 'MATCH FORMAT'),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildFormatChip('4 × 15 MIN'),
            const SizedBox(width: 12),
            _buildFormatChip('2 × 35 MIN'),
            const SizedBox(width: 12),
            _buildFormatChip('CUSTOM'),
          ],
        ),
        const SizedBox(height: 40),
        const SectionHeader(title: 'MATCH ID'),
        _buildMatchIdCard(),
      ],
    );
  }

  Widget _buildReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'MATCH PREVIEW'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF191D20),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildReviewTeam(_selectedHomeTeam),
                  Text(
                    'VS',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white10,
                    ),
                  ),
                  _buildReviewTeam(_selectedAwayTeam),
                ],
              ),
              const SizedBox(height: 32),
              _buildReviewRow(
                Icons.emoji_events_outlined,
                _tournamentController.text.isEmpty
                    ? 'Tournament'
                    : _tournamentController.text,
              ),
              const SizedBox(height: 12),
              _buildReviewRow(
                Icons.location_on_outlined,
                _venueController.text.isEmpty ? 'Venue' : _venueController.text,
              ),
              const SizedBox(height: 12),
              _buildReviewRow(
                Icons.access_time_rounded,
                '${_selectedDate.day} ${_getMonth(_selectedDate.month)} • ${_selectedTime.format(context)}',
              ),
              const SizedBox(height: 12),
              _buildReviewRow(Icons.timer_outlined, _selectedFormat),
              const SizedBox(height: 24),
              const Divider(color: Colors.white10),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'MATCH ID',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'HK2026-0001',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF00E5FF),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _currentStep = 0),
            child: const Text(
              'EDIT DETAILS',
              style: TextStyle(
                color: Color(0xFF39FF14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    bool isLast = _currentStep == 2;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0D0F),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: GradientButton(
        text: isLast ? 'CREATE MATCH' : 'NEXT STEP',
        onPressed: () {
          if (isLast) {
            _showSuccessDialog();
          } else {
            setState(() => _currentStep++);
          }
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF141719),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white10, fontSize: 14),
              prefixIcon: Icon(icon, color: const Color(0xFF39FF14), size: 18),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickerField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF141719),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF39FF14), size: 18),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSelector(String label, String current, bool isHome) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF191D20),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                current.substring(0, 1),
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                current,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: const Text(
            'SELECT',
            style: TextStyle(
              color: Color(0xFF39FF14),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormatChip(String label) {
    bool isSelected = _selectedFormat == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFormat = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF39FF14).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF39FF14)
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF39FF14) : Colors.white38,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchIdCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF00E5FF).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.qr_code_rounded, color: Color(0xFF00E5FF), size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HK2026-0001',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: const Color(0xFF00E5FF),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Connects stream, recording & AI analysis.',
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
          const StatusBadge(text: 'READY', color: Color(0xFF39FF14)),
        ],
      ),
    );
  }

  Widget _buildReviewRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white24, size: 16),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }

  Widget _buildReviewTeam(String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          child: Text(
            name.substring(0, 1),
            style: const TextStyle(color: Colors.white24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141719),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF39FF14),
                size: 64,
              ),
              const SizedBox(height: 24),
              const Text(
                'MATCH CREATED',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Match ID: HK2026-0001',
                style: GoogleFonts.inter(
                  color: const Color(0xFF00E5FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'READY TO STREAM',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: 'GO TO MATCH',
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonth(int m) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[m - 1];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _tournamentController.dispose();
    _venueController.dispose();
    super.dispose();
  }
}
