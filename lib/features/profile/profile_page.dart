import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModernAppBar(title: 'Account'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1A1A1A),
              child: Icon(Icons.person, size: 50, color: Colors.white24),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hockey Professional',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'premium_user@hockey.ai',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 32),
            _buildProfileGroup('Account', [
              _buildProfileItem(
                Icons.person_outline_rounded,
                'Personal Information',
              ),
              _buildProfileItem(Icons.security_rounded, 'Security'),
            ]),
            _buildProfileGroup('Preferences', [
              _buildProfileItem(
                Icons.notifications_none_rounded,
                'Notifications',
              ),
              _buildProfileItem(Icons.language_rounded, 'Language'),
              _buildProfileItem(Icons.dark_mode_outlined, 'Appearance'),
            ]),
            _buildProfileGroup('Support', [
              _buildProfileItem(Icons.help_outline_rounded, 'Help Center'),
              _buildProfileItem(Icons.info_outline_rounded, 'About'),
            ]),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF39FF14),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: items),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white24),
      onTap: () {},
    );
  }
}
