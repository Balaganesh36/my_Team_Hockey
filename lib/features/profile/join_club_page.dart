import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class JoinClubPage extends StatefulWidget {
  const JoinClubPage({super.key});

  @override
  State<JoinClubPage> createState() => _JoinClubPageState();
}

class _JoinClubPageState extends State<JoinClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join PPG Hockey Club")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SectionHeader(title: "Application Form"),
            const SportsCard(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Full Name"),
                  ),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: "Age")),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Preferred Position",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: "Phone Number"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: "SUBMIT APPLICATION",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Application Submitted!")),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
