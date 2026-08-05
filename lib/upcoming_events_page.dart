//TODO Implement this library.// upcoming_events_page.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // If you use Google Fonts
//
// class UpcomingEventsPage extends StatelessWidget {
//   // You might want to pass events data here in the future
//   // final List<Map<String, dynamic>> events; // Example data parameter
//   // UpcomingEventsPage({Key? key, required this.events}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Sample event data - Replace this with your actual data source later
//     List<Map<String, dynamic>> events = [
//       {
//         'title': 'PPG 7s ALUMNI HOCKEY TORMENT',
//         'date': '2025-07-15',
//         'time': '9.00am',
//         'location': 'ppg hockey ground',
//         'description': 'join and show your talent',
//       },
//       {
//         'title': 'ZONE 11',
//         'date': '2025-04-22',
//         'time': '10:00',
//         'location': 'Kct hockey ground',
//         'description': 'Qualifier for the Regional Championship.',
//       },
//       {
//         'title': 'Friendly Match',
//         'date': '2025-04-29',
//         'time': '11.00',
//         'location': 'ppg hockey ground',
//         'description': 'Friendly match against the Riverside Raiders.',
//       },
//       {
//         'title': 'DISTRICT SELECTION',
//         'date': '2025-04-09',
//         'time': '11.00',
//         'location': 'Suguna collage turf',
//         'description': 'Best opportunity for skilled players',
//       },
//       {
//         'title': 'STATE LEVEL 11s HOCKEY TOURNAMENT',
//         'date': '2025-06-29',
//         'time': '11.00',
//         'location': 'Ppg hockey',
//         'description': 'Best opportunity for skilled players',
//       },
//       // Add more events...
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Upcoming Events",
//           style: GoogleFonts.oldenburg(
//             // Apply your desired font/style
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         backgroundColor: Colors.black, // Match your app's theme
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: events.isEmpty
//           ? Center(
//               child: Text(
//                 'No upcoming events.',
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//           : ListView.builder(
//               padding: EdgeInsets.all(16.0),
//               itemCount: events.length,
//               itemBuilder: (context, index) {
//                 final event = events[index];
//                 return Card(
//                   margin: EdgeInsets.only(bottom: 16.0),
//                   elevation: 4.0,
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(16.0),
//                     title: Text(
//                       event['title'],
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(Icons.calendar_today, size: 16),
//                             SizedBox(width: 8),
//                             Text(event['date']),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.access_time, size: 16),
//                             SizedBox(width: 8),
//                             Text(event['time']),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.location_on, size: 16),
//                             SizedBox(width: 8),
//                             Text(event['location']),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           event['description'] ?? '',
//                         ), // Handle potential null description
//                       ],
//                     ),
//                     // You can add a trailing icon or button if needed
//                     // trailing: Icon(Icons.arrow_forward_ios),
//                     // onTap: () {
//                     //   // Handle tapping an event (e.g., show details)
//                     // },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
