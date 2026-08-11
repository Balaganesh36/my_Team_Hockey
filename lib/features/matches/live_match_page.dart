import 'package:flutter/material.dart';
import '../../shared/widgets/app_widgets.dart';

class LiveMatchPage extends StatelessWidget {
  const LiveMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const ModernAppBar(title: 'Live Stream'),
      body: Column(
        children: [
          // Video Area
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: const Color(0xFF1A1A1A),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    size: 64,
                    color: Color(0xFF39FF14),
                  ),
                  Positioned(top: 16, left: 16, child: LiveBadge()),
                ],
              ),
            ),
          ),
          // Score Area
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF0D0D0D),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'IND',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '2 - 1',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF39FF14),
                          ),
                        ),
                        Text(
                          'Q3 | 12:45',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      'AUS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Timeline/Stats
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Color(0xFF39FF14),
                    tabs: [
                      Tab(text: 'TIMELINE'),
                      Tab(text: 'STATS'),
                      Tab(text: 'REPORT'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTimeline(),
                        _buildStats(),
                        _buildReport(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildTimelineItem(
          '42\'',
          'Goal - IND',
          Icons.sports_hockey_rounded,
          const Color(0xFF39FF14),
        ),
        _buildTimelineItem(
          '38\'',
          'Green Card - AUS',
          Icons.rectangle_rounded,
          Colors.green,
        ),
        _buildTimelineItem(
          '25\'',
          'Penalty Corner - IND',
          Icons.flag_rounded,
          Colors.white,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String time,
    String event,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(time, style: const TextStyle(color: Colors.white54)),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 12),
          Text(event, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return const Center(
      child: Text(
        'AI Enhanced Statistics View',
        style: TextStyle(color: Color(0xFF00E5FF)),
      ),
    );
  }

  Widget _buildReport() {
    return const Center(
      child: Text(
        'Report Stream / Issue',
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
