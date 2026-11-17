import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../matches/live_match_page.dart';
import '../../matches/matches_page.dart';

class TodaysLiveMatchesSection extends StatefulWidget {
  const TodaysLiveMatchesSection({super.key});

  @override
  State<TodaysLiveMatchesSection> createState() =>
      _TodaysLiveMatchesSectionState();
}

class _TodaysLiveMatchesSectionState extends State<TodaysLiveMatchesSection>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late ScrollController _scrollController;
  late AnimationController _pulseController;
  Timer? _autoScrollTimer;
  Timer? _resumeTimer;
  bool _isUserInteracting = false;
  List<Map<String, dynamic>> _todaysMatches = [];

  // Accent Colors
  static const Color neonLime = Color(0xFFD7FF00);
  static const Color darkCardBg = Color(0xFF101B2B);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scrollController = ScrollController();

    // Pulse animation controller for the LIVE badge dot
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _loadAndFilterTodaysMatches();
    _startAutoScroll();
  }

  void _loadAndFilterTodaysMatches() {
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    final allMatches = AppConstants.getTodaysLiveMatches();

    // Filter matches scheduled for the local date
    setState(() {
      _todaysMatches = allMatches.where((match) {
        final matchDate = match['date']?.toString();
        return matchDate == todayStr;
      }).toList();
    });
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_todaysMatches.length <= 1) return;

    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 3500), (_) {
      if (!_isUserInteracting && _scrollController.hasClients && mounted) {
        final double maxScroll = _scrollController.position.maxScrollExtent;
        final double currentScroll = _scrollController.offset;
        const double cardWidth = 310.0; // Card width (290) + margin (20)
        double targetScroll = currentScroll + cardWidth;

        if (targetScroll >= maxScroll + 20) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
          );
        } else {
          _scrollController.animateTo(
            targetScroll,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
  }

  void _onUserTouchStart() {
    _isUserInteracting = true;
    _resumeTimer?.cancel();
  }

  void _onUserTouchEnd() {
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _isUserInteracting = false;
        });
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _autoScrollTimer?.cancel();
      _pulseController.stop();
    } else if (state == AppLifecycleState.resumed) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _autoScrollTimer?.cancel();
    _resumeTimer?.cancel();
    _scrollController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row: Section Title & VIEW ALL Action
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: neonLime,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "TODAY'S LIVE MATCHES",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MatchesPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'VIEW ALL',
                      style: GoogleFonts.inter(
                        color: neonLime,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: neonLime,
                      size: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Carousel Body
        if (_todaysMatches.isEmpty)
          _buildEmptyState()
        else
          SizedBox(
            height: 195,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollStartNotification &&
                    notification.dragDetails != null) {
                  _onUserTouchStart();
                } else if (notification is ScrollEndNotification) {
                  _onUserTouchEnd();
                }
                return false;
              },
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _todaysMatches.length,
                itemBuilder: (context, index) {
                  final match = _todaysMatches[index];
                  return _buildMatchCard(context, match);
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: darkCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white38,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              'No matches scheduled for today',
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, dynamic> match) {
    final String status = match['status'] ?? 'UPCOMING';
    final bool isLive = status == 'LIVE';
    final bool isCompleted = status == 'COMPLETED';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LiveMatchPage()),
        );
      },
      child: Container(
        width: 290,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: darkCardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isLive ? neonLime.withValues(alpha: 0.3) : Colors.white10,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isLive
                  ? neonLime.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Top Bar: Status Badge + Tournament Name + Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(status),
                Expanded(
                  child: Text(
                    match['competition'] ?? 'Tournament',
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Teams & Score Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Team A
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF162337),
                          border: Border.all(
                            color: isLive ? neonLime : Colors.white24,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            (match['homeTeam'] ?? 'A').toString().substring(
                              0,
                              1,
                            ),
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        match['homeTeam'] ?? 'Team A',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Animated Score / Status Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          isCompleted
                              ? '${match['homeScore']} - ${match['awayScore']}'
                              : isLive
                              ? '${match['homeScore']} - ${match['awayScore']}'
                              : 'VS',
                          key: ValueKey(
                            '${match['homeScore']}_${match['awayScore']}',
                          ),
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: isLive ? neonLime : Colors.white,
                          ),
                        ),
                      ),
                      if (isLive) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${match['period']} • ${match['time']}',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: neonLime,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Team B
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF162337),
                          border: Border.all(color: Colors.white24, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            (match['awayTeam'] ?? 'B').toString().substring(
                              0,
                              1,
                            ),
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        match['awayTeam'] ?? 'Team B',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(color: Colors.white10, height: 1),
            const SizedBox(height: 8),

            // Card Bottom: Location, Date & Start Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 11,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      match['location'] ?? 'Venue',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Today • ${match['startTime'] ?? 'TBD'}',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    if (status == 'LIVE') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _pulseController,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: neonLime,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'LIVE',
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: neonLime,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    } else if (status == 'UPCOMING') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF2677FF).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF2677FF).withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          'UPCOMING',
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2677FF),
            letterSpacing: 0.5,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'COMPLETED',
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: Colors.white54,
            letterSpacing: 0.5,
          ),
        ),
      );
    }
  }
}
