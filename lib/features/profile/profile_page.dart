import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/app_widgets.dart';
import '../auth/login_page.dart';
import 'contact_page.dart';
import 'join_club_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/images/download.jpeg"),
          ),
          const SizedBox(height: 16),
          Text(
            "Bala Ganesh V.",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Text(
            "Premium Member",
            style: TextStyle(
              color: Color(0xFF1565C0),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          _buildMenuSection(context),
          const SizedBox(height: 32),
          GradientButton(
            text: "LOGOUT",
            colors: [Colors.red[700]!, Colors.red[400]!],
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return GlassCard(
      opacity: 0.05,
      child: Column(
        children: [
          _buildMenuItem(context, Icons.person_outline, "Account Settings"),
          const Divider(height: 1, indent: 64),
          _buildMenuItem(
            context,
            Icons.rule,
            "Match Rules",
            onTap: () => _showRules(context),
          ),
          const Divider(height: 1, indent: 64),
          _buildMenuItem(
            context,
            Icons.people_outline,
            "Join PPG Club",
            onTap: () => _showJoinClub(context),
          ),
          const Divider(height: 1, indent: 64),
          _buildMenuItem(
            context,
            Icons.help_outline,
            "Contact Us",
            onTap: () => _showContact(context),
          ),
          const Divider(height: 1, indent: 64),
          _buildMenuItem(context, Icons.security_outlined, "Privacy Policy"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1565C0)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showRules(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(32),
            children: [
              const SectionHeader(title: "Match Rules"),
              ...AppConstants.matchRules.map(
                (rule) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SportsCard(child: Text(rule)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJoinClub(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JoinClubPage()),
    );
  }

  void _showContact(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactPage()),
    );
  }
}
