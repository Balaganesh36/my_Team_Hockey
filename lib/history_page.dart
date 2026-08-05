// history_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchHistoryPage extends StatelessWidget {
  const MatchHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample match history data - Replace with your actual data source
    List<Map<String, dynamic>> matchHistory = [
      {
        'opponent': 'PPG Vs KCT ',
        'date': '2025-03-10',
        'result': 'Win',
        'score': '5 - 3',
        'location': 'ppg hockey truf',
        'competition': 'Zone 11',
      },
      {
        'opponent': 'PPG VS Adhiyaman ',
        'date': '2025-02-28',
        'result': 'Win',
        'score': '6 - 4',
        'location': 'ppg hockey truf',
        'competition': 'InterZone',
      },
      {
        'opponent': 'PPG VS Kongu college of engineering',
        'date': '2025-02-15',
        'result': 'Win',
        'score': '7 - 1',
        'location': 'kongu college hockey ground',
        'competition': 'Friendly',
      },
      {
        'opponent': 'PPG VS SREC ',
        'date': '2025-01-22',
        'result': 'Draw',
        'score': '3 - 3',
        'location': 'ppg hockey truf',
        'competition': 'State level 7s hockey tournament',
      },
      {
        'opponent': 'PPG  VS PPG alumni ',
        'date': '2025-01-22',
        'result': 'loss',
        'score': '2 - 3',
        'location': 'ppg hockey truf',
        'competition': 'State level hockey tournament',
      },
      {
        'opponent': 'PPG VS UIT',
        'date': '2025-01-22',
        'result': 'win',
        'score': '6 - 3',
        'location': 'ppg hockey truf',
        'competition': ' UIT  7s hockey tournament',
      },
      {
        'opponent': 'KCT VS UIT ',
        'date': '2025-01-22',
        'result': 'win',
        'score': '6 - 3',
        'location': 'ppg hockey truf',
        'competition': '  State level 7s hockey tournament',
      },
      // Add more ma
      // tches...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Match History",
          style: GoogleFonts.oldenburg(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        // Set the background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              // --- Replace with your actual image path ---
              "assets/images/0d449779-543a-45dd-8917-2851183908a4.jpg",
              // Example: "assets/images/0d449779-543a-45dd-8917-2851183908a4.jpg",
              // --- Replace with your actual image path ---
            ),
            fit: BoxFit.cover, // Cover the entire container
          ),
        ),
        child: // Use Stack or Opacity to ensure readability
        Stack(
          children: [
            // Semi-transparent overlay for better text readability
            Container(
              color: Colors.black.withOpacity(
                0.6,
              ), // Adjust opacity (0.0 to 1.0) as needed
            ),
            matchHistory.isEmpty
                ? const Center(
                    child: Text(
                      'No match history available.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: matchHistory.length,
                    itemBuilder: (context, index) {
                      final match = matchHistory[index];
                      Color resultColor;
                      IconData resultIcon;

                      switch (match['result']?.toLowerCase()) {
                        case 'win':
                          resultColor = Colors.green;
                          resultIcon = Icons.check_circle;
                          break;
                        case 'loss':
                          resultColor = Colors.red;
                          resultIcon = Icons.cancel;
                          break;
                        case 'draw':
                          resultColor = Colors.orange;
                          resultIcon =
                              Icons.change_history; // Or Icons.minimize
                          break;
                        default:
                          resultColor = Colors.grey;
                          resultIcon = Icons.help;
                      }

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Opponent and Result
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      match['opponent'] ?? 'Unknown Opponent',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        resultIcon,
                                        color: resultColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        match['result'] ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: resultColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Score
                              Center(
                                child: Text(
                                  match['score'] ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Details (Date, Competition, Location)
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 8),
                                  Text(match['date'] ?? 'Date Unknown'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.emoji_events_outlined,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(match['competition'] ?? 'Friendly'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16),
                                  const SizedBox(width: 8),
                                  Text(match['location'] ?? 'Location Unknown'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
