// highlights_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// 1. Import the video_player package
import 'package:video_player/video_player.dart';

// 2. Create a stateful widget for the individual video player screen
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl; // URL of the video to play
  final String title; // Optional title for the app bar

  const VideoPlayerScreen({
    Key? key,
    required this.videoUrl,
    required this.title,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // 3. Create and initialize the VideoPlayerController
    _controller = VideoPlayerController.asset(
      widget.videoUrl,
    ); // Use .network for URLs, .asset for local files

    // 4. Initialize the controller and store the Future for later use
    _initializeVideoPlayerFuture = _controller.initialize();

    // 5. (Optional) Loop the video
    // _controller.setLooping(true);
  }

  @override
  void dispose() {
    // 6. Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.oldenburg(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 7. If the Future is complete, display the video player
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            // 8. If the Future is still loading, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 9. Toggle play/pause
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        // 10. Display the correct icon based on the video state
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

// 11. Main HighlightsPage Widget
class HighlightsPage extends StatelessWidget {
  const HighlightsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 12. Sample data for highlights (Replace with your actual data)
    // Ensure 'videoUrl' points to a direct video file link (e.g., .mp4)
    List<Map<String, dynamic>> highlights = [
      {
        'title': 'Goal of the Week - Amazing Strike!',
        'thumbnailUrl':
            'assets/images/summer-olympic-spotlight-field-hockey-players-engage-fierce-face-off-penalty-corner-seen-up-close-359950061.webp', // Replace with actual thumbnail URL
        'videoUrl':
            'assets/videos/assetsvideoshighlights.mp4_.mp4', // Replace with actual video URL
        'description': 'Watch this incredible goal scored in the last match.',
      },
      {
        'title': 'Best Saves from the Tournament',
        'thumbnailUrl':
            'assets/images/download.jpeg', // Replace with actual thumbnail URL
        'videoUrl':
            'assets/videos/assetsvideoshighlights.mp4_.mp4', // Replace with actual video URL
        'description': 'Compilation of the best saves by our goalkeepers.',
      },
      {
        'title': 'Best scores',
        'thumbnailUrl':
            'assets/images/summer-olympic-spotlight-field-hockey-players-engage-fierce-face-off-penalty-corner-seen-up-close-359950061.webp', // Replace with actual thumbnail URL
        'videoUrl':
            'assets/videos/assetsvideoshighlights.mp4_.mp4', // Replace with actual video URL
        'description': 'Captain Akshay shares his thoughts after the victory.',
      },
      // Add more highlights...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Highlights",
          style: GoogleFonts.oldenburg(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: highlights.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No highlights available yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: highlights.length,
              itemBuilder: (context, index) {
                final highlight = highlights[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 4.0,
                  child: InkWell(
                    onTap: () {
                      // 13. Navigate to the VideoPlayerScreen when the card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoUrl: highlight['videoUrl'],
                            title: highlight['title'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 14. Display Thumbnail (using Image.network for URL)
                          // Consider using cached_network_image for better performance
                          ClipRRect(
                            // Optional: Rounds the corners of the thumbnail
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              highlight['thumbnailUrl'] ??
                                  'https://via.placeholder.com/300x200?text=No+Image',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Handle image loading errors
                                return Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          // 15. Display Title
                          Text(
                            highlight['title'] ?? 'Untitled Highlight',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          // 16. Display Description (optional)
                          Text(
                            highlight['description'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // 17. Optional: Play Icon Overlay on Thumbnail or a dedicated Play button
                          // For simplicity, tapping the whole card plays the video.
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
                                      videoUrl: highlight['videoUrl'],
                                      title: highlight['title'],
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.play_circle_fill,
                                color: Colors.deepPurple,
                              ),
                              label: const Text('Watch'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
