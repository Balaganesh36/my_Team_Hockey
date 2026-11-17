import 'package:flutter/material.dart';

class TournamentMockData {
  static final List<Map<String, dynamic>> tournaments = [
    {
      'id': 'TRN-2026-01',
      'name': 'PPG 7s State Hockey Championship',
      'category': 'State Level',
      'description':
          'Annual state level 7s hockey tournament for top college and club teams.',
      'startDate': '2026-11-20',
      'endDate': '2026-11-25',
      'venue': 'PPG Hockey Turf',
      'city': 'Coimbatore',
      'organiserName': 'PPG Sports Committee',
      'phone': '+91 9876543210',
      'whatsapp': '+91 9876543210',
      'email': 'tournaments@ppg.edu.in',
      'registrationLink': 'https://ppghockey.in/register',
      'status': 'Approved', // Draft, Pending, Approved, Rejected
      'teams': ['PPG', 'TIGERS', 'KCT', 'LIONS', 'UIT', 'SNS'],
      'fixtures': [
        {
          'id': 'HK2026-0101',
          'teamA': 'PPG',
          'teamB': 'TIGERS',
          'matchDate': '2026-11-20 10:00 AM',
          'venue': 'PPG Hockey Turf',
          'stage': 'Group Stage - Round 1',
        },
        {
          'id': 'HK2026-0102',
          'teamA': 'KCT',
          'teamB': 'LIONS',
          'matchDate': '2026-11-20 02:00 PM',
          'venue': 'PPG Hockey Turf',
          'stage': 'Group Stage - Round 1',
        },
      ],
    },
    {
      'id': 'TRN-2026-02',
      'name': 'District Junior Selection Tournament',
      'category': 'District Level',
      'description': 'District selection matches for U-21 players.',
      'startDate': '2026-12-05',
      'endDate': '2026-12-07',
      'venue': 'KCT Sports Complex',
      'city': 'Coimbatore',
      'organiserName': 'District Hockey Association',
      'phone': '+91 9123456789',
      'whatsapp': '+91 9123456789',
      'email': 'dha@hockey.org',
      'registrationLink': 'https://dha.org/u21',
      'status': 'Pending',
      'teams': ['KCT', 'UIT', 'PAVAI', 'PSG'],
      'fixtures': [
        {
          'id': 'HK2026-0201',
          'teamA': 'UIT',
          'teamB': 'PAVAI',
          'matchDate': '2026-12-05 09:30 AM',
          'venue': 'KCT Sports Complex',
          'stage': 'Quarter Final',
        },
      ],
    },
    {
      'id': 'TRN-2026-03',
      'name': 'Friendly Inter-College Cup',
      'category': 'Inter-College',
      'description': 'Tournament setup for regional friendly games.',
      'startDate': '2026-12-15',
      'endDate': '2026-12-16',
      'venue': 'Suguna College Turf',
      'city': 'Coimbatore',
      'organiserName': 'Akshay & Team',
      'phone': '+91 9988776655',
      'whatsapp': '+91 9988776655',
      'email': 'akshay@hockey.ai',
      'registrationLink': 'https://hockey.ai/friendly',
      'status': 'Draft',
      'teams': ['PPG', 'PSG'],
      'fixtures': [],
    },
  ];

  static Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF39FF14);
      case 'Pending':
        return const Color(0xFFFFC93C);
      case 'Rejected':
        return const Color(0xFFEF4444);
      case 'Draft':
      default:
        return const Color(0xFF94A3B8);
    }
  }
}
