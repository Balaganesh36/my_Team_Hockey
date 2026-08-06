import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Us")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SportsCard(
              child: Column(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF1565C0), size: 40),
                  SizedBox(height: 16),
                  Text(
                    "PPG Hockey Ground, Coimbatore",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildContactItem(Icons.phone, "+91 98765 43210"),
            _buildContactItem(Icons.email, "info@myteamhockey.com"),
            const SizedBox(height: 32),
            const SectionHeader(title: "Send Message"),
            const GlassCard(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(decoration: InputDecoration(hintText: "Your Name")),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(hintText: "Your Email"),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(hintText: "Your Message"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GradientButton(text: "SEND MESSAGE", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1565C0)),
        title: Text(text),
      ),
    );
  }
}
