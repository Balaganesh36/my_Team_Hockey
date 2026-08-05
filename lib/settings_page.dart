// settings_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  // Supported languages
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'ta', 'name': 'Tamil'},
    {'code': 'hi', 'name': 'Hindi'},
    {'code': 'te', 'name': 'Telugu'},
    {'code': 'kn', 'name': 'Kannada'},
  ];
  void _showPrivacyPolicyDialog(BuildContext context) {
    final String privacyPolicy = '''
Welcome to MyTeamHockey!

At MyTeamHockey, we are committed to protecting your privacy and ensuring that your personal information is handled securely and responsibly. This Privacy Policy explains how we collect, use, and protect your information when you use our app.

1. Information We Collect
   - Personal Information: We may collect your name, email address, phone number, and location if you choose to provide it during registration or contact.
   - Device Information: We collect non-personal data such as device type, operating system, and app usage statistics to improve performance.

2. How We Use Your Information
   - To provide and maintain our services.
   - To notify you about updates, training schedules, or events.
   - To respond to your inquiries and support requests.
   - To improve our app based on user feedback and behavior.

3. Data Storage and Security
   - Your data is stored securely using industry-standard practices.
   - We do not share your personal information with third parties except for essential services (e.g., email communication).
   - All data is stored in compliance with applicable data protection laws.

4. Cookies and Tracking
   - Our app does not use cookies but may use anonymous analytics to understand app usage.

5. Children's Privacy
   - Our services are not intended for children under 13. We do not knowingly collect information from children.

6. Changes to This Privacy Policy
   - We may update this policy from time to time. You will be notified of any major changes via the app.

7. Contact Us
   - If you have any questions about this Privacy Policy, please contact us at:
     Email: privacy@myteamhockey.com
     Address: PPG Hockey Ground, Saravanampatti, Coimbatore, Tamil Nadu - 641045

By using MyTeamHockey, you agree to the collection and use of information as described in this policy.
  ''';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Privacy Policy",
            style: GoogleFonts.oldenburg(color: Colors.deepPurpleAccent),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  privacyPolicy,
                  style: GoogleFonts.oldStandardTt(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Close",
                style: TextStyle(color: Colors.deepPurpleAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  // Get saved language
  Future<String> _getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageCode') ?? 'en'; // default to English
  }

  // Save selected language
  Future<void> _saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', code);
  }

  Future<void> _launchAppStore(BuildContext context) async {
    if (Platform.isAndroid) {
      const androidPackageName = 'com.example.my_app_6';
      final url =
          'https://play.google.com/store/apps/details?id=$androidPackageName';
      final uri = Uri.parse(url.trim());

      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          _showMessage(context, "Could not open Google Play Store.");
        }
      } on Exception catch (e) {
        _showMessage(context, "Error: $e");
      }
    } else if (Platform.isIOS) {
      _showMessage(context, "iOS version coming soon! Check back later.");
    } else {
      _showMessage(context, "Not supported on this platform.");
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 3)),
    );
  }

  // ★ Show 5-star rating dialog
  Future<void> _showRatingDialog(BuildContext context) async {
    double rating = 0.0;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rate This App", style: GoogleFonts.oldenburg()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How would you rate this app?",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.deepPurpleAccent,
                      size: 36,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _handleRatingSubmitted(index + 1.0, context);
                    },
                  );
                }),
              ),
              SizedBox(height: 10),
              Text(
                "Tap a star to submit",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _handleRatingSubmitted(double rating, BuildContext context) {
    if (rating == 5) {
      _launchAppStore(context);
      _showMessage(
        context,
        "Thank you for 5 stars! Redirecting to Play Store...",
      );
    } else {
      _showMessage(context, "Thanks for your feedback! We'll improve.");
    }
  }

  // 🌐 Show language selection dialog
  Future<void> _showLanguageDialog(BuildContext context) async {
    String? selectedLanguage = await _getSavedLanguage();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Language", style: GoogleFonts.oldenburg()),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    return RadioListTile(
                      title: Text(lang['name']!),
                      value: lang['code'],
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value;
                        });
                      },
                    );
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _saveLanguage(selectedLanguage!);
                Navigator.pop(context);
                _showMessage(
                  context,
                  "Language changed to ${languages.firstWhere((l) => l['code'] == selectedLanguage)['name']}",
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,

        titleTextStyle: GoogleFonts.oldenburg(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        // ✅ Background Image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/images.jpeg"), //
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<String>(
          future: _getSavedLanguage(),
          builder: (context, snapshot) {
            String languageName = "Loading...";
            if (snapshot.hasData) {
              final lang = languages.firstWhere(
                (l) => l['code'] == snapshot.data,
                orElse: () => languages[0],
              );
              languageName = lang['name']!;
            }

            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "App Settings",
                    style: GoogleFonts.oldenburg(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Notifications
                  ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: Colors.deepPurpleAccent,
                    ),
                    title: Text(
                      "Notifications",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    subtitle: Text(
                      "Manage your notification preferences",
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    trailing: Switch(value: true, onChanged: (_) {}),
                  ),

                  // Dark Mode
                  ListTile(
                    leading: Icon(
                      Icons.dark_mode,
                      color: Colors.deepPurpleAccent,
                    ),
                    title: Text(
                      "Dark Mode",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    subtitle: Text(
                      "Enable dark theme",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    trailing: Switch(value: false, onChanged: (_) {}),
                  ),

                  // Language
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.deepPurpleAccent,
                    ),
                    title: Text(
                      "Language",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    subtitle: Text(languageName), // Shows selected language
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      _showLanguageDialog(context);
                    },
                  ),

                  // Privacy Policy
                  ListTile(
                    leading: Icon(
                      Icons.privacy_tip,
                      color: Colors.deepPurpleAccent,
                    ),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      _showPrivacyPolicyDialog(context);
                    },
                  ),

                  // ★ Rate This App
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.deepPurpleAccent),
                    title: Text(
                      "Rate This App",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    subtitle: Text(
                      "We'd love your feedback!",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      _showRatingDialog(context);
                    },
                  ),

                  SizedBox(height: 40),

                  // Back Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
