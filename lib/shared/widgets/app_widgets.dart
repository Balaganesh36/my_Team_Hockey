import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onActionPressed;
  final String actionLabel;

  const SectionHeader({
    super.key,
    required this.title,
    this.onActionPressed,
    this.actionLabel = 'See All',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          if (onActionPressed != null)
            TextButton(
              onPressed: onActionPressed,
              child: Text(
                actionLabel,
                style: const TextStyle(
                  color: Color(0xFF1565C0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SportsCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const SportsCard({super.key, required this.child, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.1,
    this.borderRadius = 24,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? colors;
  final double? width;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.colors,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [const Color(0xFF1565C0), const Color(0xFF42A5F5)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (colors?.first ?? const Color(0xFF1565C0)).withValues(
              alpha: 0.3,
            ),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  final Map<String, dynamic> player;
  final VoidCallback? onTap;

  const PlayerCard({super.key, required this.player, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: SportsCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: player['image'] != null
                      ? DecorationImage(
                          image: AssetImage(player['image']),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey[800],
                ),
                child: player['image'] == null
                    ? Center(
                        child: Text(
                          player['jerseyNumber'].toString(),
                          style: GoogleFonts.orbitron(
                            fontSize: 40,
                            color: Colors.white24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        player['position'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Text(
                        '#${player['jerseyNumber']}',
                        style: const TextStyle(
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;

  const NewsCard({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SportsCard(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Map<String, dynamic> highlight;
  final VoidCallback onTap;

  const VideoCard({super.key, required this.highlight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SportsCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  highlight['thumbnailUrl'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    highlight['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    highlight['description'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
