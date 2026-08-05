// upcoming_events_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample event data - Replace this with your actual data source later
    List<Map<String, dynamic>> events = [
      {
        'title': 'PPG 7s ALUMNI HOCKEY TOURNAMENT', // Corrected spelling
        'date': '2025-07-15',
        'time': '9.00 am',
        'location': 'PPG Hockey Ground',
        'description': 'Join and show your talent!',
      },
      {
        'title': 'ZONE 11',
        'date': '2025-04-22',
        'time': '10:00 AM',
        'location': 'KCT Hockey Ground',
        'description': 'Qualifier for the Regional Championship.',
      },
      {
        'title': 'Friendly Match',
        'date': '2025-04-29',
        'time': '11:00 AM',
        'location': 'PPG Hockey Ground',
        'description': 'Friendly match against the Riverside Raiders.',
      },
      {
        'title': 'DISTRICT SELECTION',
        'date': '2025-04-09',
        'time': '11:00 AM',
        'location': 'Suguna College Turf', // Corrected spelling
        'description': 'Best opportunity for skilled players.',
      },
      {
        'title': 'STATE LEVEL 11s HOCKEY TOURNAMENT',
        'date': '2025-06-29',
        'time': '11:00 AM',
        'location': 'PPG Hockey Ground',
        'description': 'Best opportunity for skilled players.',
      },
      // Add more events...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upcoming Events",
          style: GoogleFonts.oldenburg(
            color: Colors.white, // Keep title white for contrast
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black, // Keep app bar solid
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // Wrap the body's main container with the background image
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/WhatsApp Image 2025-07-24 at 21.14.55_93f5b580.jpg',
            ), // <-- Your image path
            fit: BoxFit.cover,
          ),
        ),
        // Use Stack to layer the overlay and content
        child: Stack(
          fit: StackFit.expand, // Ensures Stack fills the Container
          children: [
            // --- TRANSPARENT OVERLAY ---
            // This Container acts as the "transparency" layer
            // Adjust the color and opacity (second value) to your liking.
            // Using black makes the image darker; white makes it lighter.
            Container(
              color: Colors.black.withOpacity(0.4), // Example: 40% opaque black
            ),
            // --- CONTENT ON TOP ---
            // Your scrollable content goes here, on top of the image and overlay
            events.isEmpty
                ? Center(
                    child: Text(
                      'No upcoming events.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ), // Adjust text color if needed
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 16.0),
                        elevation: 4.0,
                        // Optional: Make cards slightly transparent or adjust their color
                        // color: Colors.white.withOpacity(0.85),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(
                            event['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(event['date']),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(event['time']),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(event['location']),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(event['description'] ?? ''),
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
