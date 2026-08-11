import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class CreateMatchPage extends StatefulWidget {
  const CreateMatchPage({super.key});

  @override
  State<CreateMatchPage> createState() => _CreateMatchPageState();
}

class _CreateMatchPageState extends State<CreateMatchPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModernAppBar(title: 'Create Match'),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) setState(() => _currentStep++);
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        steps: [
          Step(
            title: const Text('Info'),
            content: _buildInfoForm(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Teams'),
            content: _buildTeamsForm(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Config'),
            content: _buildConfigForm(),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: const Text('Preview'),
            content: _buildPreview(),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoForm() {
    return Column(
      children: [
        _buildTextField('Match Name'),
        const SizedBox(height: 16),
        _buildTextField('Competition'),
        const SizedBox(height: 16),
        _buildTextField('Location'),
      ],
    );
  }

  Widget _buildTeamsForm() {
    return Column(
      children: [
        _buildTextField('Home Team'),
        const SizedBox(height: 16),
        _buildTextField('Away Team'),
      ],
    );
  }

  Widget _buildConfigForm() {
    return Column(
      children: [
        const Text(
          'Match Configuration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Enable AI Analytics'),
          value: true,
          onChanged: (v) {},
          activeThumbColor: const Color(0xFF39FF14),
        ),
        SwitchListTile(
          title: const Text('Public Stream'),
          value: false,
          onChanged: (v) {},
          activeThumbColor: const Color(0xFF39FF14),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return const Column(
      children: [
        MatchCard(
          match: {'homeTeam': 'Team A', 'awayTeam': 'Team B', 'score': '0 - 0'},
        ),
        SizedBox(height: 16),
        Text(
          'Match ID: AIH-2026-X892',
          style: TextStyle(
            color: Color(0xFF00E5FF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
