import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        titleTextStyle: GoogleFonts.oldenburg(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/images.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                Text(
                  "Get In Touch",
                  style: GoogleFonts.oldenburg(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Contact Info Cards
                _buildContactCard(
                  context,
                  icon: Icons.location_on,
                  title: "Address",
                  info:
                      "PPG Hockey Ground, Saravanampatti, Coimbatore, Tamil Nadu - 641045",
                ),
                _buildContactCard(
                  context,
                  icon: Icons.phone,
                  title: "Phone",
                  info: "+91 98765 43210\n+91 87654 32109",
                ),
                _buildContactCard(
                  context,
                  icon: Icons.email,
                  title: "Email",
                  info: "bala@myteamhockey.com\nppg@myteamhockey.com",
                ),
                _buildContactCard(
                  context,
                  icon: Icons.access_time,
                  title: "Training Hours",
                  info:
                      "Monday - Friday: 6:00 AM - 8:00 AM\nSaturday: 7:00 AM - 9:00 AM\nSunday: Rest Day",
                ),

                // Social Media
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "Follow Us on Social Media",
                    style: GoogleFonts.oldStandardTt(
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(context, 'Facebook'),
                    const SizedBox(width: 16),
                    _buildSocialIcon(context, 'Instagram'),
                    const SizedBox(width: 16),
                    _buildSocialIcon(context, 'YouTube'),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String info,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.deepPurpleAccent, size: 26),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.oldenburg(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    info,
                    style: GoogleFonts.oldStandardTt(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, String platform) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Opening $platform..."),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
      child: Text(
        platform[0],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
