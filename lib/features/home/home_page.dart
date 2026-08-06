import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/app_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section / Live Score
          _buildLiveScore(context),

          const SectionHeader(title: "Upcoming Events"),
          _buildEventsList(),

          const SectionHeader(title: "Top Highlights"),
          _buildHighlightsList(context),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLiveScore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        opacity: 0.8,
        borderRadius: 32,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLiveIndicator(),
                const Text(
                  "2nd Period",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTeamScore("PPG", "assets/images/download.jpeg", "3"),
                Text(
                  ":",
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
                _buildTeamScore("TIGERS", null, "2"),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white24),
            const SizedBox(height: 12),
            const Text(
              "PPG Hockey Turf, Coimbatore",
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "LIVE",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamScore(String name, String? logo, String score) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white10,
          backgroundImage: logo != null ? AssetImage(logo) : null,
          child: logo == null
              ? const Icon(Icons.sports_hockey, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          score,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 32,
          ),
        ),
      ],
    );
  }

  Widget _buildEventsList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.upcomingEvents.length,
        itemBuilder: (context, index) {
          final event = AppConstants.upcomingEvents[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: NewsCard(
              title: event['title'],
              date: "${event['date']} • ${event['time']}",
              imageUrl: "assets/images/images.jpeg",
            ),
          );
        },
      ),
    );
  }

  Widget _buildHighlightsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: AppConstants.highlights.map((h) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: VideoCard(
              highlight: h,
              onTap: () {
                // Navigate to video player
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
