import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/widgets/app_widgets.dart';
import '../data/tournament_mock_data.dart';

class RegisterTournamentPage extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final bool isEditing;

  const RegisterTournamentPage({
    super.key,
    this.initialData,
    this.isEditing = false,
  });

  @override
  State<RegisterTournamentPage> createState() => _RegisterTournamentPageState();
}

class _RegisterTournamentPageState extends State<RegisterTournamentPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _venueController;
  late TextEditingController _cityController;
  late TextEditingController _organiserController;
  late TextEditingController _phoneController;
  late TextEditingController _whatsappController;
  late TextEditingController _emailController;
  late TextEditingController _regLinkController;

  String _category = 'State Level';
  final List<String> _categories = [
    'State Level',
    'District Level',
    'Inter-College',
    'Club Level',
    'Friendly',
  ];

  @override
  void initState() {
    super.initState();
    final data = widget.initialData ?? {};
    _nameController = TextEditingController(text: data['name'] ?? '');
    _descriptionController = TextEditingController(
      text: data['description'] ?? '',
    );
    _startDateController = TextEditingController(text: data['startDate'] ?? '');
    _endDateController = TextEditingController(text: data['endDate'] ?? '');
    _venueController = TextEditingController(text: data['venue'] ?? '');
    _cityController = TextEditingController(text: data['city'] ?? '');
    _organiserController = TextEditingController(
      text: data['organiserName'] ?? '',
    );
    _phoneController = TextEditingController(text: data['phone'] ?? '');
    _whatsappController = TextEditingController(text: data['whatsapp'] ?? '');
    _emailController = TextEditingController(text: data['email'] ?? '');
    _regLinkController = TextEditingController(
      text: data['registrationLink'] ?? '',
    );

    if (data['category'] != null && _categories.contains(data['category'])) {
      _category = data['category'];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _venueController.dispose();
    _cityController.dispose();
    _organiserController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _regLinkController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF39FF14),
              onPrimary: Colors.black,
              surface: Color(0xFF101B2B),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  void _saveTournament(String status) {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Tournament Name')),
      );
      return;
    }

    final newTournament = {
      'id':
          widget.initialData?['id'] ??
          'TRN-2026-0${TournamentMockData.tournaments.length + 1}',
      'name': _nameController.text.trim(),
      'category': _category,
      'description': _descriptionController.text.trim(),
      'startDate': _startDateController.text.trim().isEmpty
          ? DateTime.now().toIso8601String().substring(0, 10)
          : _startDateController.text.trim(),
      'endDate': _endDateController.text.trim().isEmpty
          ? DateTime.now().toIso8601String().substring(0, 10)
          : _endDateController.text.trim(),
      'venue': _venueController.text.trim().isEmpty
          ? 'Hockey Ground'
          : _venueController.text.trim(),
      'city': _cityController.text.trim().isEmpty
          ? 'Coimbatore'
          : _cityController.text.trim(),
      'organiserName': _organiserController.text.trim(),
      'phone': _phoneController.text.trim(),
      'whatsapp': _whatsappController.text.trim(),
      'email': _emailController.text.trim(),
      'registrationLink': _regLinkController.text.trim(),
      'status': status,
      'teams': widget.initialData?['teams'] ?? ['PPG', 'TIGERS'],
      'fixtures': widget.initialData?['fixtures'] ?? [],
    };

    if (widget.isEditing) {
      final idx = TournamentMockData.tournaments.indexWhere(
        (t) => t['id'] == widget.initialData?['id'],
      );
      if (idx != -1) {
        TournamentMockData.tournaments[idx] = newTournament;
      }
    } else {
      TournamentMockData.tournaments.insert(0, newTournament);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == 'Draft'
              ? 'Saved as Draft'
              : 'Tournament Registration Submitted Successfully!',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D18),
      appBar: ModernAppBar(
        title: widget.isEditing ? 'Edit Tournament' : 'Register Tournament',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Tournament Information'),
              _buildInputField(
                controller: _nameController,
                label: 'Tournament Name *',
                hint: 'e.g. State Level 7s Hockey Cup',
                icon: Icons.emoji_events_outlined,
              ),
              const SizedBox(height: 16),
              _buildDropdownField(),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Brief details about the tournament...',
                icon: Icons.description_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Schedule & Venue'),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      controller: _startDateController,
                      label: 'Start Date',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDateField(
                      controller: _endDateController,
                      label: 'End Date',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _venueController,
                label: 'Venue Name',
                hint: 'e.g. PPG Hockey Turf',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _cityController,
                label: 'City',
                hint: 'e.g. Coimbatore',
                icon: Icons.location_city_outlined,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Organiser Contact Details'),
              _buildInputField(
                controller: _organiserController,
                label: 'Organiser Name',
                hint: 'e.g. PPG Sports Association',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hint: '+91 9876543210',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      controller: _whatsappController,
                      label: 'WhatsApp Number',
                      hint: '+91 9876543210',
                      icon: Icons.chat_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _emailController,
                label: 'Contact Email',
                hint: 'organiser@hockey.org',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                controller: _regLinkController,
                label: 'Registration Link',
                hint: 'https://tournament.org/register',
                icon: Icons.link_outlined,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 32),

              // Action Buttons: Save as Draft & Submit
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _saveTournament('Draft'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF94A3B8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'SAVE AS DRAFT',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF94A3B8),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _saveTournament('Pending'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF39FF14),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'SUBMIT',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF39FF14),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
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
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 13),
            prefixIcon: Icon(icon, color: const Color(0xFF39FF14), size: 20),
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
          'Category *',
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
              value: _category,
              dropdownColor: const Color(0xFF101B2B),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF39FF14),
              ),
              isExpanded: true,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              items: _categories.map((cat) {
                return DropdownMenuItem<String>(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _category = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
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
          readOnly: true,
          onTap: () => _selectDate(controller),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'YYYY-MM-DD',
            hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 13),
            prefixIcon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF39FF14),
              size: 20,
            ),
            filled: true,
            fillColor: const Color(0xFF101B2B),
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
          ),
        ),
      ],
    );
  }
}
