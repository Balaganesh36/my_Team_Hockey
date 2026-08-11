import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/app_widgets.dart';

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'role': 'ai',
      'text':
          'Hello! I am your AI Hockey Intelligence assistant. I can analyze match events, explain rules, or provide coaching insights. How can I help you today?',
      'time': '10:00 AM',
    },
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final userText = _controller.text.trim();
    setState(() {
      _messages.add({'role': 'user', 'text': userText, 'time': '10:05 AM'});
      _controller.clear();
    });

    // Simulate AI Response
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'role': 'ai',
            'text': _getAIResponse(userText),
            'time': '10:05 AM',
          });
        });
        _scrollToBottom();
      }
    });
    _scrollToBottom();
  }

  String _getAIResponse(String query) {
    final q = query.toLowerCase();
    if (q.contains('penalty corner') || q.contains('rule')) {
      return 'A penalty corner is awarded for a foul by a defender within the shooting circle that does not prevent a probable goal. Based on the match data, 3 corners were awarded today due to obstruction.';
    } else if (q.contains('performance') || q.contains('stats')) {
      return 'The overall team performance rating is 8.4/10. Akshay showed a high intensity index (9.2) in the final quarter, contributing to the winning goal.';
    } else if (q.contains('training') || q.contains('improve')) {
      return 'I recommend focusing on "Lateral Defensive Movement" drills. Data suggests the team conceded 65% of circle entries from the right flank.';
    }
    return 'That is an interesting observation. Analyzing the match intelligence for more details... Is there anything specific about the tactics or player positioning you would like to know?';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModernAppBar(title: 'Hockey Intelligence'),
      body: Column(
        children: [
          // Intelligence Insights Header (Horizontal)
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildQuickInsight(
                  'Match Summary',
                  Icons.summarize_rounded,
                  const Color(0xFF39FF14),
                ),
                _buildQuickInsight(
                  'Coach Insights',
                  Icons.psychology_rounded,
                  const Color(0xFF00E5FF),
                ),
                _buildQuickInsight(
                  'Training Plan',
                  Icons.fitness_center_rounded,
                  Colors.orangeAccent,
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white10, height: 1),

          // Chat Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(
                  msg['role'] == 'ai',
                  msg['text'],
                  msg['time'],
                );
              },
            ),
          ),

          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildQuickInsight(String title, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(bool isAi, String text, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isAi
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (isAi)
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF00E5FF),
                child: Icon(Icons.auto_awesome, size: 16, color: Colors.black),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isAi
                    ? const Color(0xFF1A1A1A)
                    : const Color(0xFF00E5FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isAi ? 4 : 20),
                  bottomRight: Radius.circular(isAi ? 20 : 4),
                ),
                border: Border.all(
                  color: isAi
                      ? Colors.white10
                      : const Color(0xFF00E5FF).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.white24, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          if (!isAi)
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF1A1A1A),
                child: Icon(Icons.person, size: 16, color: Colors.white54),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ask AI about the match...',
                    hintStyle: const TextStyle(
                      color: Colors.white24,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.psychology_rounded,
                      color: Color(0xFF00E5FF),
                      size: 20,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF39FF14),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF39FF14).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
