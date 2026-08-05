// match_rules_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchRulesPage extends StatelessWidget {
  // Sample hockey rules data
  final List<String> rules = [
    "1. Game Duration: A standard match consists of two halves of 35 minutes each, with a 5-10 minute halftime break.",
    "2. Team Size: Each team has 11 players on the field, including one goalkeeper.",
    "3. Ball in Play: The ball must be played with the flat side of the stick. Using the backside is a foul.",
    "4. Offside Rule: Field hockey does not have an offside rule, allowing free movement across the field.",
    "5. Penalty Corners: Awarded for defensive fouls inside the shooting circle or intentional fouls on the attacker.",
    "6. Goals: A goal is scored when the ball fully crosses the goal line within the goalposts and under the crossbar.",
    "7. Cards: Green card (warning), Yellow card (temporary suspension), Red card (ejection from the game).",
    "8. Substitutions: Unlimited rolling substitutions are allowed from the substitution area.",
    "9. Tie Breakers: If required, matches may go into extra time or penalty shootouts.",
    "10. Stick & Equipment: Sticks must conform to regulations. No dangerous equipment is permitted.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match Rules"),
        titleTextStyle: GoogleFonts.oldenburg(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 4,
      ),
      body: Container(
        color: Color.fromARGB(255, 228, 228, 153),
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: rules.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  rules[index],
                  style: GoogleFonts.oldStandardTt(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
